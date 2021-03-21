#!/bin/bash

tool="<tool></tool>"

txt="<txt>"
[[ $(checkupdates | wc -l) -gt 0 ]] && txt+="<span foreground='white'></span> <span weight='Bold'>Updates available</span>"
txt+="</txt>"

echo -e "$txt"
echo -e "$tool"
