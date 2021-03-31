#!/usr/bin/env bash

script_dir="/home/spike/.local/bin"

echo -en "\x00prompt\x1fscript  >>\n"

if [[ -z "$@" ]]; then
    echo -e "password\nyoutube"
else
    case "$@" in
        password)
            coproc (zsh -c "$script_dir/rofi-keepassxc-cli.sh" > /dev/null);;
        youtube)
            coproc (YTFZF_EXTMENU=' rofi -normal-window -dmenu -fuzzy -width 1500 -l 20 -p youtube:' ytfzf -D > /dev/null);;
        *)
            exit 1
    esac
fi
