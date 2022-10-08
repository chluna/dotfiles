#!/bin/bash

tool="<tool></tool>"

title="$(xdotool getactivewindow getwindowname | cut -c -128)"

txt="<txt>"
if [[ $title != "Desktop" ]]; then
    txt+="$title"
fi
txt+="</txt>"

echo -e "$txt"
echo -e "$tool"
