# Process info helper: top CPU processes + process tree (+ optional PID deep-dive)
# Usage: procinfo [PID]
# UI: colori e layout leggibile (solo se stdout è un TTY).

procinfo() {
  local pid="$1"
  local top_n="${PROCINFO_TOP_N:-15}"
  local cmd_max="${PROCINFO_CMD_MAX:-56}"
  local use_color=0
  [[ -t 1 ]] && use_color=1

  # Colori (solo se TTY)
  local R="\033[0m"
  local B="\033[1m"
  local D="\033[90m"
  local C="\033[36m"
  local Y="\033[33m"
  local G="\033[32m"
  local M="\033[35m"
  [[ $use_color -eq 0 ]] && R="" && B="" && D="" && C="" && Y="" && G="" && M=""

  _pc() { print -n "$1"; }
  _pl() { print "$1"; }
  _sep() { _pl "${D}────────────────────────────────────────────────────────────────────────${R}"; }
  _blank() { _pl ""; }

  if [[ -n "$pid" && "$pid" != <-> ]]; then
    echo "Usage: procinfo [PID]" >&2
    return 1
  fi

  if [[ -n "$pid" ]]; then
    # --- Deep-dive per un singolo PID ---
    if ! kill -0 "$pid" 2>/dev/null; then
      echo "Processo $pid non trovato o non accessibile." >&2
      return 1
    fi
    _blank
    _pc "${C}${B}  ▸ Catena processi (PID → padre) per $pid${R}"; _pl ""
    _sep
    local p="$pid"
    while [[ -n "$p" && "$p" != "0" ]]; do
      local line args args_trim
      line=$(ps -p "$p" -o pid=,ppid=,pcpu=,pmem=,comm= 2>/dev/null)
      _pl "${Y}  PID ${p}${R}  $(echo "$line" | awk '{printf "PPID %s  CPU %s%%  MEM %s%%  %s", $2, $3, $4, $5}')"
      args=$(ps -p "$p" -ww -o args= 2>/dev/null)
      [[ -z "$args" ]] && args="(comando non disponibile)"
      args_trim=$(printf '%s\n' "$args" | awk -v m="$cmd_max" 'length($0)>m {print substr($0,1,m)"..."; next} {print}')
      _pl "  ${D}${args_trim}${R}"
      _blank
      p=$(ps -p "$p" -o ppid= 2>/dev/null | tr -d ' ')
    done
    _sep
    _blank
    _pc "${C}${B}  ▸ Sample 3s (dove spende tempo)${R}"; _pl ""
    _sep
    sample "$pid" 3 2>/dev/null | sed 's/^/  /' || _pl "  ${D}(sample non disponibile)${R}"
    _blank
    _sep
    _blank
    _pc "${C}${B}  ▸ File aperti (prime 25)${R}"; _pl ""
    _sep
    lsof -p "$pid" 2>/dev/null | head -25 | sed 's/^/  /'
    _blank
    return 0
  fi

  # --- Overview: top per CPU ---
  _blank
  _pl "${B}${M}  procinfo — processi e albero${R}"
  _blank
  _pc "${C}${B}  ▸ Top ${top_n} processi per CPU${R}"; _pl ""
  _sep
  _pl "${B}  ${D}PID     PPID    CPU%    MEM%   Comando (max ${cmd_max} caratteri)${R}"
  _sep
  ps -eww -o pid,ppid,pcpu,pmem,args 2>/dev/null | \
    sort -k3 -rn 2>/dev/null | \
    head -n "$top_n" | \
    awk -v m="$cmd_max" '{
      cmd=""; for(i=5;i<=NF;i++) cmd=cmd $i " "; gsub(/^ +| +$/,"",cmd);
      if(length(cmd)>m) cmd=substr(cmd,1,m) "…";
      cpu=$3+0; mem=$4+0;
      printf "  %-7s %-7s %6.1f%% %6.1f%%  %s\n", $1, $2, cpu, mem, cmd
    }'
  _sep
  _blank

  # --- Albero processi (profondità limitata per leggibilità) ---
  _pc "${C}${B}  ▸ Albero processi (pstree, max 3 livelli, prime 50 righe)${R}"; _pl ""
  _sep
  if command -v pstree &>/dev/null; then
    pstree -w -l 3 2>/dev/null | head -50 | sed 's/^/  /' | while read -r line; do
      _pl "${D}${line}${R}"
    done
    _pl "  ${D}… (usa 'pstree -w' per l'albero completo)${R}"
  else
    _pl "  ${D}pstree non installato. Esegui: brew install pstree${R}"
  fi
  _blank
}
