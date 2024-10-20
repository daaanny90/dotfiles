#!/bin/bash

# Recupera la percentuale della batteria con pmset
battery_level=$(pmset -g batt | grep '[0-9][0-9]%' | awk 'NR==1{print$3}' | cut -c 1-3 | tr -d '%')

# Se la batteria è inferiore a 100, formatta con due cifre
if [ "$battery_level" -lt 100 ]; then
  printf "%02d\n" "$battery_level"
else
  echo "$battery_level"
fi
