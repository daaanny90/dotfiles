#!/bin/bash
# Memory usage for tmux status bar
# Icon:  (fa-memory), color by usage level

mem=$(printf '\357\205\233')  # F15B fa-memory

# Get memory pressure percentage (used + compressed vs total)
mem_info=$(vm_stat 2>/dev/null)
if [ -z "$mem_info" ]; then
  echo "#[fg=#B8B8B8]${mem} -"
  exit 0
fi

page_size=16384
total_pages=$(sysctl -n hw.memsize 2>/dev/null | awk "{print int(\$1/$page_size)}")
free=$(echo "$mem_info" | awk '/Pages free/ {gsub(/\./,""); print $3}')
inactive=$(echo "$mem_info" | awk '/Pages inactive/ {gsub(/\./,""); print $3}')
purgeable=$(echo "$mem_info" | awk '/Pages purgeable/ {gsub(/\./,""); print $3}')

[ -z "$free" ] && free=0
[ -z "$inactive" ] && inactive=0
[ -z "$purgeable" ] && purgeable=0

used_pct=$(echo "$total_pages $free $inactive $purgeable" | awk '{
  available = $2 + $3 + $4
  used = $1 - available
  pct = (used / $1) * 100
  if (pct > 100) pct = 100
  if (pct < 0) pct = 0
  printf "%.0f", pct
}')

# Swap indicator
swap_used=$(sysctl vm.swapusage 2>/dev/null | awk '{for(i=1;i<=NF;i++) if($i=="used") print $(i+2)}' | tr -d 'M,')
swap_flag=""
if [ -n "$swap_used" ] && [ "$(echo "$swap_used > 1024" | bc 2>/dev/null)" = "1" ]; then
  swap_gb=$(echo "$swap_used" | awk '{printf "%.0f", $1/1024}')
  swap_flag=" ${swap_gb}Gs"
fi

# Colors: green ok, yellow mid, coral high, red critical
sym='#B8B8B8'
if   [ "$used_pct" -lt 50 ];  then fg='#6BA86B'   # green
elif [ "$used_pct" -lt 70 ];  then fg='#D4A84B'   # yellow
elif [ "$used_pct" -lt 85 ];  then fg='#D4835A'   # coral
else fg='#C75C5C'; fi                              # red

echo "#[fg=$sym]${mem}#[fg=$fg] ${used_pct}%${swap_flag}"
