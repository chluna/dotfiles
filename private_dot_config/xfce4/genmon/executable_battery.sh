#!/bin/bash

bat0=$(cat /sys/class/power_supply/BAT0/capacity)
bat1=$(cat /sys/class/power_supply/BAT1/capacity)
bat=$(echo "($bat0 + $bat1)/2" | qalc -t -f - | awk '{printf("%.0f"), $1}')

if [[ $(cat /sys/class/power_supply/AC/online) -eq 1 ]]; then
    if [[ $bat -ge 99 ]]; then
        icon="\UF0085 "
    elif [[ $bat -ge 90 ]]; then
        icon="\UF008B "
    elif [[ $bat -ge 80 ]]; then
        icon="\UF008A "
    elif [[ $bat -ge 70 ]]; then
        icon="\UF089E "
    elif [[ $bat -ge 60 ]]; then
        icon="\UF0089 "
    elif [[ $bat -ge 50 ]]; then
        icon="\UF089D "
    elif [[ $bat -ge 40 ]]; then
        icon="\UF0088 "
    elif [[ $bat -ge 30 ]]; then
        icon="\UF0087 "
    elif [[ $bat -ge 20 ]]; then
        icon="\UF0086 "
    elif [[ $bat -ge 10 ]]; then
        icon="\UF089C "
    else
        icon="\UF089F "
    fi
else
    if [[ $bat -ge 99 ]]; then
        icon="\UF0079"
    elif [[ $bat -ge 90 ]]; then
        icon="\UF0082"
    elif [[ $bat -ge 80 ]]; then
        icon="\UF0081"
    elif [[ $bat -ge 70 ]]; then
        icon="\UF0080"
    elif [[ $bat -ge 60 ]]; then
        icon="\UF007F"
    elif [[ $bat -ge 50 ]]; then
        icon="\UF007E"
    elif [[ $bat -ge 40 ]]; then
        icon="\UF007D"
    elif [[ $bat -ge 30 ]]; then
        icon="\UF007C"
    elif [[ $bat -ge 20 ]]; then
        icon="\UF007B"
    elif [[ $bat -ge 10 ]]; then
        icon="\UF007A"
    else
        icon="\UF10CD"
    fi
fi

if [[ $bat -ge 80 ]]; then
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
tool+="internal:\t$bat0%\nexternal:\t$bat1%"
tool+="</tool>"

txtclick="<txtclick>"
txtclick+="xfce4-power-manager-settings"
txtclick+="</txtclick>"

echo -e "$txt"
echo -e "$tool"
echo -e "$txtclick"
