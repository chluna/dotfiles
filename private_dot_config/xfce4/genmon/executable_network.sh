#!/bin/bash

txt="<txt>"
tool="<tool>"
txtclick="<txtclick>"

wlan_dev="wlan0"
eth_dev="enp0s31f6"

wlan="$(nmcli -p device show $wlan_dev | grep IP4.ADDRESS | tr -s ' ' | cut -d ' ' -f 2 | cut -d '/' -f 1)"
ssid="$(nmcli -p device show $wlan_dev | grep GENERAL.CONNECTION | tr -s ' ' | cut -d ' ' -f 2)"
eth="$(nmcli -p device show $eth_dev | grep IP4.ADDRESS | tr -s ' ' | cut -d ' ' -f 2 | cut -d '/' -f 1)"

if [[ ! -z "$wlan" && ! -z "$eth" ]]; then
    txt+="\UF05A9  $ssid  \UF0200  eth"
    tool+="wlan: $wlan\nlan: $eth"
elif [[ ! -z "$wlan" && -z "$eth" ]]; then
    txt+="\UF05A9  $ssid"
    tool+="wlan: $wlan"
elif [[ -z "$wlan" && ! -z "$eth" ]]; then
    txt+="\UF0200  eth"
    tool+="lan: $eth" 
else
    txt+="\UF0C5F "
fi

public="$(curl ipinfo.io | jq -r '.ip')"

if [[ ! -z "$public" ]]; then
    tool+="\npublic: $public"
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
