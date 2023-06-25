#!/bin/bash

txt="<txt>"
tool="<tool>"
txtclick="<txtclick>"

wlan="$(nmcli -p device show wlp3s0 | grep IP4.ADDRESS | tr -s ' ' | cut -d ' ' -f 2 | cut -d '/' -f 1)"
ssid="$(nmcli -p device show wlp3s0 | grep GENERAL.CONNECTION | tr -s ' ' | cut -d ' ' -f 2)"
eth="$(nmcli -p device show enp0s31f6 | grep IP4.ADDRESS | tr -s ' ' | cut -d ' ' -f 2 | cut -d '/' -f 1)"

if [[ ! -z "$wlan" && ! -z "$eth" ]]; then
    txt+="\UF05A9  $ssid  \UF0200  eth"
    tool+="wlan:\t$wlan\nlan:\t$eth"
elif [[ ! -z "$wlan" && -z "$eth" ]]; then
    txt+="\UF05A9  $ssid"
    tool+="wlan:\t$wlan"
elif [[ -z "$wlan" && ! -z "$eth" ]]; then
    txt+="\UF0200  eth"
    tool+="lan:\t$eth" 
else
    txt+="\UF0C5F "
fi

public="$(curl ipinfo.io | jq -r '.ip')"

if [[ ! -z "$public" ]]; then
    tool+="\npublic:\t$public"
else
    txt+=" offline"
fi

txtclick+="bash -c '~/.config/xfce4/genmon/network_reset.sh "$ssid"'"

txt+="</txt>"
tool+="</tool>"
txtclick+="</txtclick>"

echo -e "$txt"
echo -e "$tool"
echo -e "$txtclick"
