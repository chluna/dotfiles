#!/bin/bash

if [[ $(cat /sys/class/power_supply/AC/online) -eq 1 ]]; then
    icon=""
else
    icon=""
fi

bat0=$(cat /sys/class/power_supply/BAT0/capacity)
bat1=$(cat /sys/class/power_supply/BAT1/capacity)
bat=$(echo "($bat0 + $bat1)/2" | qalc -t -f - | awk '{printf("%.0f"), $1}')
if [[ $bat -ge 98 ]]; then
	color="green"
elif [[ $bat -ge 10 ]] && [[ $bat -lt 20 ]]; then
    color="yellow"
elif [[ $bat -lt 10 ]]; then
    color="red"
else
	color="white"
fi

txt="<txt>"
txt+="<span foreground='$color'>$icon</span> $bat%"
txt+="</txt>"

tool="<tool>"
tool+="internal: $bat0%\nexternal: $bat1%"
tool+="</tool>"

txtclick="<txtclick>"
txtclick+="xfce4-power-manager-settings"
txtclick+="</txtclick>"

echo -e "$txt"
echo -e "$tool"
echo -e "$txtclick"
