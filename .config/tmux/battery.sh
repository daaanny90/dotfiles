#!/bin/bash
# Output bar + percentage for tmux status bar (standard colors)
# Bar: ▪ filled, ▫ empty - 5 segments. Charging: icon 7 (fa-bolt) after %
# Charging: green | Discharging: green(high) / yellow(mid) / red(low)
bolt=$(printf '\357\203\247')  # 7 F0E7 fa-bolt
batt=$(pmset -g batt 2>/dev/null)
pct=$(echo "$batt" | grep -oE '(100|[0-9]{1,2})%' | head -1 | tr -d '%')
[ -z "$pct" ] && exit 0
if   [ "$pct" -le 19 ]; then bar="□□□□□"
elif [ "$pct" -le 39 ]; then bar="■□□□□"
elif [ "$pct" -le 59 ]; then bar="■■□□□"
elif [ "$pct" -le 79 ]; then bar="■■■□□"
elif [ "$pct" -le 99 ]; then bar="■■■■□"
else bar="■■■■■"; fi
# Color: green when charging, else by level (green/yellow/red)
if echo "$batt" | grep -q 'discharging'; then
  [ "$pct" -ge 60 ] && fg='#6BA86B'     # green
  [ "$pct" -ge 20 ] && [ "$pct" -lt 60 ] && fg='#D4A84B'  # yellow
  [ "$pct" -lt 20 ] && fg='#C75C5C'     # red
  suffix=""
else
  fg='#6BA86B'   # green (charging or charged)
  suffix=" ${bolt}"
fi
echo "#[fg=$fg]$bar ${pct}%$suffix"
