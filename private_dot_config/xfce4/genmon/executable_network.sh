#!/bin/bash

txt="<txt>"
tool="<tool>"
txtclick="<txtclick>"

wlan="$(nmcli -p device show wlp3s0 | grep IP4.ADDRESS | tr -s ' ' | cut -d ' ' -f 2 | cut -d '/' -f 1)"
ssid="$(nmcli -p device show wlp3s0 | grep GENERAL.CONNECTION | tr -s ' ' | cut -d ' ' -f 2)"
eth="$(nmcli -p device show enp0s31f6 | grep IP4.ADDRESS | tr -s ' ' | cut -d ' ' -f 2 | cut -d '/' -f 1)"

if [[ ! -z "$wlan" && ! -z "$eth" ]]; then
    txt+="直 wifi   wire"
    tool+="ssid: $ssid\nwlan: $wlan\nlan: $eth"
elif [[ ! -z "$wlan" && -z "$eth" ]]; then
    txt+="直 wifi"
    tool+="ssid: $ssid\nwlan: $wlan"
elif [[ -z "$wlan" && ! -z "$eth" ]]; then
    txt+=" wire"
    tool+="lan: $eth" 
else
    txt+="泌"
fi

public="$(curl ipinfo.io | jq -r '.ip')"

if [[ ! -z "$public" ]]; then
    tool+="\npublic: $public"
else
    txt+=" (offline)"
fi

txtclick+="bash -c '~/.config/xfce4/genmon/network_reset.sh "$ssid"'"

txt+="</txt>"
tool+="</tool>"
txtclick+="</txtclick>"

echo -e "$txt"
echo -e "$tool"
echo -e "$txtclick"
