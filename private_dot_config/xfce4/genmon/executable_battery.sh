#!/bin/bash

bat0_energy_now_raw=$(cat /sys/class/power_supply/BAT0/energy_now)
bat0_energy_full_raw=$(cat /sys/class/power_supply/BAT0/energy_full)
bat0_energy_now=$(echo "$bat0_energy_now_raw/1000" | qalc -t -f -)
bat0_energy_full=$(echo "$bat0_energy_full_raw/1000" | qalc -t -f -)
bat0_pct=$(echo "100*$bat0_energy_now/$bat0_energy_full" | qalc -t -f - | awk '{printf("%.0f"), $1}')

bat1_energy_now_raw=$(cat /sys/class/power_supply/BAT1/energy_now)
bat1_energy_full_raw=$(cat /sys/class/power_supply/BAT1/energy_full)
bat1_energy_now=$(echo "$bat1_energy_now_raw/1000" | qalc -t -f -)
bat1_energy_full=$(echo "$bat1_energy_full_raw/1000" | qalc -t -f -)
bat1_pct=$(echo "100*$bat1_energy_now/$bat1_energy_full" | qalc -t -f - | awk '{printf("%.0f"), $1}')

bat_pct=$(echo "100*($bat0_energy_now + $bat1_energy_now)/($bat0_energy_full + $bat1_energy_full)" | qalc -t -f - | awk '{printf("%.0f"), $1}')

if [[ $(cat /sys/class/power_supply/AC/online) -eq 1 ]]; then
    if [[ $bat_pct -ge 99 ]]; then
        icon="\UF0085 "
    elif [[ $bat_pct -ge 90 ]]; then
        icon="\UF008B "
    elif [[ $bat_pct -ge 80 ]]; then
        icon="\UF008A "
    elif [[ $bat_pct -ge 70 ]]; then
        icon="\UF089E "
    elif [[ $bat_pct -ge 60 ]]; then
        icon="\UF0089 "
    elif [[ $bat_pct -ge 50 ]]; then
        icon="\UF089D "
    elif [[ $bat_pct -ge 40 ]]; then
        icon="\UF0088 "
    elif [[ $bat_pct -ge 30 ]]; then
        icon="\UF0087 "
    elif [[ $bat_pct -ge 20 ]]; then
        icon="\UF0086 "
    elif [[ $bat_pct -ge 10 ]]; then
        icon="\UF089C "
    else
        icon="\UF089F "
    fi
else
    if [[ $bat_pct -ge 99 ]]; then
        icon="\UF0079"
    elif [[ $bat_pct -ge 90 ]]; then
        icon="\UF0082"
    elif [[ $bat_pct -ge 80 ]]; then
        icon="\UF0081"
    elif [[ $bat_pct -ge 70 ]]; then
        icon="\UF0080"
    elif [[ $bat_pct -ge 60 ]]; then
        icon="\UF007F"
    elif [[ $bat_pct -ge 50 ]]; then
        icon="\UF007E"
    elif [[ $bat_pct -ge 40 ]]; then
        icon="\UF007D"
    elif [[ $bat_pct -ge 30 ]]; then
        icon="\UF007C"
    elif [[ $bat_pct -ge 20 ]]; then
        icon="\UF007B"
    elif [[ $bat_pct -ge 10 ]]; then
        icon="\UF007A"
    else
        icon="\UF10CD"
    fi
fi

if [[ $bat_pct -ge 80 ]]; then
    color="green"
elif [[ $bat_pct -ge 10 ]] && [[ $bat_pct -lt 20 ]]; then
    color="yellow"
elif [[ $bat_pct -lt 10 ]]; then
    color="red"
else
    color="white"
fi

txt="<txt>"
txt+="<span foreground='$color'>$icon</span> $bat_pct%"
txt+="</txt>"

tool="<tool>"
tool+="internal: $bat0_pct% ($bat0_energy_now mWh/$bat0_energy_full mWh)\nexternal: $bat1_pct% ($bat1_energy_now mWh/$bat1_energy_full mWh)"
tool+="</tool>"

txtclick="<txtclick>"
txtclick+="xfce4-power-manager-settings"
txtclick+="</txtclick>"

echo -e "$txt"
echo -e "$tool"
echo -e "$txtclick"
