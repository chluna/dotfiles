#!/bin/bash

color="white"

tool="<tool></tool>"

txt="<txt>"
pkg=$(checkupdates | wc -l)
if [[ $pkg -ge 1 ]]; then 
	txt+="<span foreground='$color'></span> $pkg"
fi
txt+="</txt>"

echo -e "$txt"
echo -e "$tool"
