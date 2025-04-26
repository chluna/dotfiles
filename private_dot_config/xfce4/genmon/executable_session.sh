#!/bin/bash

user=$(whoami)
hostname=$(uname -n)
kernel=$(uname -r)
uptime=$(uptime -p | cut -d ' ' -f 2-)

txt="<txt>"
txt+="\UF303 "
txt+="</txt>"

tool="<tool>"
tool+="<span weight='Bold'>$user@$hostname\n"
tool+="kernel: $kernel</span>\n"
tool+="uptime: $uptime"
tool+="</tool>"

txtclick="<txtclick>"
txtclick+="xfce4-session-logout"
txtclick+="</txtclick>"

echo -e "$txt"
echo -e "$tool"
echo -e "$txtclick"
