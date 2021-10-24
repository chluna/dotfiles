#!/bin/bash

updates=$(checkupdates | wc -l)

txt="<txt>"
[[ $updates -gt 0 ]] && txt+=" Updates available"
txt+="</txt>"

tool="<tool>"
[[ $updates -gt 0 ]] && tool+="$(checkupdates | cut -d' ' -f1)"
tool+="</tool>"

echo -e "$txt"
echo -e "$tool"
