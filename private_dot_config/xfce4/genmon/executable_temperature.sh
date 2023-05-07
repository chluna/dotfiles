#!/bin/bash

temp=$(cat /sys/class/thermal/thermal_zone0/temp | awk '{printf("%.0f", $1 / 1000.0)}')
if [[ $temp -ge 85 ]]; then
    icon="\UF2C7"
	color="red"
elif [[ $temp -gt 70 ]]; then
    icon="\UF2C8"
    color="orange"
elif [[ $temp -gt 55 ]]; then
    icon="\UF2C9"
    color="orange"
elif [[ $temp -gt 40 ]]; then
    icon="\UF2CA"
    color="yellow"
else
    icon="\UF2CB"
	color="white"
fi

txt="<txt>"
txt+="<span foreground='$color'>$icon</span>  $temp°"
txt+="</txt>"

echo -e "$txt"
echo -e "$tool"
