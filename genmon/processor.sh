#!/bin/bash

tool="<tool></tool>"

proc=$(vmstat 1 2 | tail -1 | awk '{printf ("%d"), $13}')
if [[ $proc -gt 60 ]] && [[ $proc -lt 80 ]]; then
	color="yellow"
elif [[ $proc -gt 80 ]]; then
	color="red"
else
	color="white"
fi

txt="<txt>"
txt+="<span foreground='$color'></span> $proc%"
txt+="</txt>"

echo -e "$txt"
echo -e "$tool"
