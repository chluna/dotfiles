#!/bin/bash

txt="<txt>"
txt+="\UF303 "
txt+="</txt>"

tool="<tool>"
tool+="<span weight='Bold'>$(whoami)@$(uname -n)\n"
tool+="$(uname -r)</span>\n"
tool+="uptime: $(uptime -p | cut -d ' ' -f 2-)"
tool+="</tool>"

echo -e "$txt"
echo -e "$tool"
