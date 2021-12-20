#!/bin/bash

temp=$(cat /sys/class/thermal/thermal_zone0/temp | awk '{printf("%.0f", $1 / 1000.0)}')
if [[ $temp -gt 50 ]] && [[ $temp -lt 65 ]]; then
    color="yellow"
elif [[ $temp -gt 65 ]] && [[ $temp -lt 80 ]]; then
    color="orange"
elif [[ $temp -gt 80 ]]; then
	color="red"
else
	color="white"
fi

txt="<txt>"
txt+="<span foreground='$color'></span> $temp°"
txt+="</txt>"

echo -e "$txt"
echo -e "$tool"
