#!/bin/bash

updates=$(checkupdates | wc -l)

txt="<txt>"
tool="<tool>"
txtclick+="<txtclick>"

if [[ $updates -gt 0 ]]; then
    txt+="\UF487  Updates available"
    tool+="$(checkupdates | cut -d' ' -f1)"
    txtclick+="kitty --hold zsh -c 'source ~/.config/zsh/.zshrc; pm up'"
fi

txt+="</txt>"
tool+="</tool>"
txtclick+="</txtclick>"

echo -e "$txt"
echo -e "$tool"
echo -e "$txtclick"
