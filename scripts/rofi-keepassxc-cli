#!/usr/bin/env bash

# rofi settings
# case-insensitive, normal window, dmenu mode
dmenu="rofi -i -normal-window -dmenu"
# keepassxc settings
# modify these two variables as needed
database="/home/spike/onedrive/me/tech/kp/pd.kdbx"
timeout=20

password=$($dmenu -p "password? " -password -l 0)
echo "$password" | keepassxc-cli ls -q "$database" > /dev/null
if [[ $? -eq 0 ]]; then
    while true; do
        entry=$(echo "$password" | keepassxc-cli ls -fRq "$database" | egrep -v "\/$|^Recycle" | cat <(echo "exit") - | $dmenu -p "entry  -> ")
        case "$entry" in
            exit)
                exit 0;;
            *)
                while [[ ! -z $entry ]]; do
                    action=$(echo -e "copy password\ncopy username\ncopy URL\nshow entry\nanother entry\nexit" | $dmenu -p "action ->" -l 6)
                    case "$action" in
                        "copy password")
                            echo "$password" | keepassxc-cli clip -q -a password "$database" "$entry" $timeout;;
                        "copy username")
                            echo "$password" | keepassxc-cli clip -q -a username "$database" "$entry" $timeout;;
                        "copy URL")
                            echo "$password" | keepassxc-cli clip -q -a URL "$database" "$entry" $timeout;;
                        "show entry")
                            echo "$password" | keepassxc-cli show -q "$database" "$entry" | egrep "Title|UserName|URL" | $dmenu -p "show   -> " -l 3 > /dev/null;;
                        "another entry")
                            break;;
                        exit)
                            exit 0;;
                        *)
                            exit 1
                    esac
                done
        esac
    done
fi
