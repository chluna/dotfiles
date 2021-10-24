#!/usr/bin/env bash

SCRIPT_DIR="/home/spike/.local/bin"

echo -en "\x00prompt\x1fscript  >>\n"

if [[ -z "$@" ]]; then
    echo -e "youtube"
    #echo -e "password\nyoutube"
else
    case "$@" in
        #password)
        #    coproc (zsh -c "$SCRIPT_DIR/rofi-keepassxc-cli" > /dev/null);;
        youtube)
            coproc (YTFZF_EXTMENU=' rofi -i -dmenu -fuzzy -width 1500 -l 20 -p youtube:' ytfzf -D > /dev/null);;
        *)
            exit 1
    esac
fi
