#!/bin/bash
# Load + temp. CPU icon 32 (fa-brain), Temp T4 (weather-thermometer)

c32=$(printf '\356\272\234')   # EE9C fa-brain
t4=$(printf '\356\215\220')    # E350 weather-thermometer

ncpu=$(sysctl -n hw.ncpu 2>/dev/null) || ncpu=1
load=$(sysctl -n vm.loadavg 2>/dev/null | awk '{print $2}')
[ -z "$load" ] && load=0
load_pct=$(echo "$load $ncpu" | awk '{v=($1/$2)*100; printf "%.0f", (v>100)?100:v}')

temp=""
[ -x /opt/homebrew/bin/macmon ] && temp=$(macmon pipe 2>/dev/null | head -1 | python3 -c "import sys,json; d=json.load(sys.stdin); print(int(d['temp']['cpu_temp_avg']))" 2>/dev/null)
[ -z "$temp" ] && temp="-"

# Colors: green ok, yellow mid, coral/red high
sym='#B8B8B8'
if   [ "$load_pct" -lt 50 ];  then lfg='#6BA86B'   # green
elif [ "$load_pct" -lt 75 ];  then lfg='#D4A84B'   # yellow
elif [ "$load_pct" -lt 90 ];  then lfg='#D4835A'   # coral
else lfg='#C75C5C'; fi                             # red

if   [ "$temp" = "-" ];       then tfg='#B8B8B8'
elif [ "$temp" -lt 60 ];     then tfg='#6BA86B'   # green
elif [ "$temp" -lt 75 ];     then tfg='#D4A84B'   # yellow
elif [ "$temp" -lt 90 ];     then tfg='#D4835A'   # coral
else tfg='#C75C5C'; fi                             # red

echo "#[fg=$sym]${c32}#[fg=$lfg] ${load_pct}% #[fg=$sym]| ${t4}#[fg=$tfg] ${temp}°#[fg=$sym]"
