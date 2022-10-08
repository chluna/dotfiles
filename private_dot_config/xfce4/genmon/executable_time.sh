#!/bin/bash

txt="<txt>"
txt+="$(date +"%H:%M")"
txt+="</txt>"

tool="<tool>"
tool+="$(date +"%A, %d %B %Y")"
tool+="</tool>"

echo -e "$txt"
echo -e "$tool"
