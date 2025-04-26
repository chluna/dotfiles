#!/bin/bash

updates=$(checkupdates | cut -d ' ' -f 1)

txt="<txt>"
txt+="\UF487"

tool="<tool>"

if [[ $updates != "" ]]; then
    txtclick="<txtclick>"
    
    txt+="  update"
    tool+=$updates
    txtclick+="kitty fish -i -c 'pm -U'"
    
    txt+="</txt>"
    tool+="</tool>"
    txtclick+="</txtclick>"

    echo -e "$txt"
    echo -e "$tool"
    echo -e "$txtclick"
else
    txt+="  none"
    txt+="</txt>"
    
    tool+="</tool>"

    echo -e "$txt"
    echo -e "$tool"
fi
