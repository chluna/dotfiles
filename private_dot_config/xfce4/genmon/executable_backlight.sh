#!/bin/bash

curLight=$(cat /sys/class/backlight/intel_backlight/brightness)
maxLight=$(cat /sys/class/backlight/intel_backlight/max_brightness)
light=$(echo 100.0*$curLight/$maxLight | qalc -t -f - | xargs printf "%d")

if [[ $light -ge 99 ]]; then
	icon="\UF06E8"
elif [[ $light -ge 90 ]]; then
	icon="\UF1A56"
elif [[ $light -ge 80 ]]; then
	icon="\UF1A55"
elif [[ $light -ge 70 ]]; then
	icon="\UF1A54"
elif [[ $light -ge 60 ]]; then
	icon="\UF1A53"
elif [[ $light -ge 50 ]]; then
	icon="\UF1A52"
elif [[ $light -ge 40 ]]; then
	icon="\UF1A51"
elif [[ $light -ge 30 ]]; then
	icon="\UF1A50"
elif [[ $light -ge 20 ]]; then
	icon="\UF1A4F"
elif [[ $light -ge 10 ]]; then
	icon="\UF1A4E"
else
	icon="\UF06E9"
fi

txt="<txt>"
txt+="$icon  $light%"
txt+="</txt>"

echo -e "$txt"
echo -e "$tool"
