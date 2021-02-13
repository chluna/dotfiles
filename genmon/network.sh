#!/bin/bash

tool="<tool>"
txt="<txt>"

wlan="$(nmcli -p device show wlp3s0 | grep IP4.ADDRESS | tr -s ' ' | cut -d ' ' -f 2 | cut -d '/' -f 1)"
ssid="$(nmcli -p device show wlp3s0 | grep GENERAL.CONNECTION | tr -s ' ' | cut -d ' ' -f 2)"
eth="$(nmcli -p device show enp0s31f6 | grep IP4.ADDRESS | tr -s ' ' | cut -d ' ' -f 2 | cut -d '/' -f 1)"

if [[ ! -z "$wlan" && ! -z "$eth" ]]; then
    txt+="直 $ssid  wired"
    tool+="wlan: $wlan\nlan: $eth"
elif [[ ! -z "$wlan" && -z "$eth" ]]; then
    txt+="直 $ssid"
    tool+="wlan: $wlan"
elif [[ -z "$wlan" && ! -z "$eth" ]]; then
    txt+=" wired"
    tool+="lan: $eth" 
else
    txt+="泌"
fi

public="$(curl icanhazip.com)"

if [[ ! -z "$public" ]]; then
    tool+="\npub: $public"
else
    txt+=" (down)"
fi

txt+="</txt>"
tool+="</tool>"

echo -e "$txt"
echo -e "$tool"
