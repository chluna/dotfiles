#!/bin/bash

mem=$(free | grep Mem | awk '{printf ("%.0f"), $3 / $2 * 100.0}')
if [[ $mem -gt 60 ]] && [[ $proc -lt 80 ]]; then
	color="yellow"
elif [[ $mem -gt 80 ]]; then
	color="red"
else
	color="white"
fi

txt="<txt>"
txt+="<span foreground='$color'></span> $mem%"
txt+="</txt>"

echo -e "$txt"
echo -e "$tool"
