#!/bin/bash

txt="<txt>"
txt+="  "
txt+="</txt>"

tool="<tool>"
tool+="$(whoami)@$(uname -n)\n"
tool+="$(uname -r)\n"
tool+="uptime: $(uptime -p | cut -d ' ' -f 2-)"
tool+="</tool>"

echo -e "$txt"
echo -e "$tool"
