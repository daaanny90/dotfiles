#!/bin/bash
# Docker status per tmux - SOLO lettura cache (nessun comando docker nel path principale)
# Un processo in background aggiorna la cache ogni 30s
# Risolve "not ready" evitando timeout su docker info / docker desktop update

# Cache fissa (TMPDIR puo' variare tra tmux e job in background)
cache_dir="/tmp/tmux_docker"
cache_file="$cache_dir/status"
cache_ts="$cache_dir/status.ts"
max_age=30

mkdir -p "$cache_dir"
now=$(date +%s)

# Leggi cache e output immediato (sempre veloce)
if [ -f "$cache_file" ] && [ -f "$cache_ts" ]; then
  ct=$(cat "$cache_ts" 2>/dev/null)
  if [ -n "$ct" ] && [ $((now - ct)) -lt $max_age ]; then
    cat "$cache_file"
    exit 0
  fi
fi

# Cache assente o scaduta: output grigio e avvia aggiornamento in background (max 1 ogni 15s)
spawn_file="$cache_dir/last_spawn"
should_spawn=true
[ -f "$spawn_file" ] && spawn_ts=$(cat "$spawn_file" 2>/dev/null) && [ $((now - spawn_ts)) -lt 5 ] && should_spawn=false

echo "#[fg=#B8B8B8]Docker"

if [ "$should_spawn" = true ]; then
  echo "$now" > "$spawn_file"
  (
    export PATH="/usr/local/bin:/opt/homebrew/bin:/Applications/Docker.app/Contents/Resources/bin:$PATH"
    DOCKER=$(command -v docker 2>/dev/null || echo "")
    [ -z "$DOCKER" ] && echo "#[fg=#B8B8B8]Docker" > "$cache_file" && date +%s > "$cache_ts" && exit 0
    out=$("$DOCKER" info 2>&1)
    ec=$?
    result="#[fg=#B8B8B8]Docker"
    if [ $ec -eq 0 ]; then
      if echo "$out" | grep -qi "error\|cannot connect\|failed"; then
        result="#[fg=#C75C5C]Docker"
      else
        update=false
        [ "$(uname -s)" = "Darwin" ] && "$DOCKER" desktop update --check-only 2>&1 | grep -qi "is available" && update=true
        if echo "$out" | grep -qi "warning"; then
          result="#[fg=#D4A84B]Docker"
        elif [ "$update" = true ]; then
          result="#[fg=#D4A84B]Docker ↑"
        else
          result="#[fg=#6BA86B]Docker"
        fi
      fi
    fi
    echo "$result" > "$cache_file"
    date +%s > "$cache_ts"
  ) &
fi

exit 0
