#!/usr/bin/env bash

awk '/^[A-za-z]/ && last {print $0,"\t",last} {last=""} /^#/{last=$0}' ~/.config/sxhkd/sxhkdrc |
    column -t -s $'\t' |
    rofi -dmenu -i -no-show-icons -p sxhkd -theme-str '#window {width:50%;} #listview {lines:15;}'