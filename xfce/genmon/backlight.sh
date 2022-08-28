#!/bin/bash

curLight=$(cat /sys/class/backlight/intel_backlight/brightness)
maxLight=$(cat /sys/class/backlight/intel_backlight/max_brightness)
light=$(echo 100.0*$curLight/$maxLight | qalc -t -f - | xargs printf "%d")

if [[ $light -lt 50 ]]; then
	icon=
else
	icon=
fi

txt="<txt>"
txt+="$icon $light%"
txt+="</txt>"

echo -e "$txt"
echo -e "$tool"
