#!/bin/bash

socket=$(ss -ax | rg @kittysock | xargs | cut -d ' ' -f 5)
conf=$HOME/.config

if [ "$XFCE_NIGHT_MODE" = "night" ]; then
  xfconf-query --channel xfce4-panel --property /panels/dark-mode --type bool --set true
  kitten @ --to unix:$socket kitten themes --reload-in=all Catppuccin-Mocha
  sed -i 's/Catppuccin Latte/Catppuccin Mocha/' $conf/bat/config
  sed -i 's/catppuccin_latte/catppuccin_mocha/' $conf/btop/btop.conf
  sed -i 's/catppuccin-latte/catppuccin-mocha/' $conf/git/config
  sed -i 's/catppuccin_latte/catppuccin_mocha/' $conf/helix/config.toml
  sed -i 's/catppuccin-latte/catppuccin-mocha/' $conf/rofi/config.rasi
  sed -i 's/catppuccin-latte/catppuccin-mocha/' $conf/yazi/theme.toml
elif [ "$XFCE_NIGHT_MODE" = "day" ]; then
  xfconf-query --channel xfce4-panel --property /panels/dark-mode --type bool --set false
  kitten @ --to unix:$socket kitten themes --reload-in=all Catppuccin-Latte
  sed -i 's/Catppuccin Mocha/Catppuccin Latte/' $conf/bat/config
  sed -i 's/catppuccin_mocha/catppuccin_latte/' $conf/btop/btop.conf
  sed -i 's/catppuccin-mocha/catppuccin-latte/' $conf/git/config
  sed -i 's/catppuccin_mocha/catppuccin_latte/' $conf/helix/config.toml
  sed -i 's/catppuccin-mocha/catppuccin-latte/' $conf/rofi/config.rasi
  sed -i 's/catppuccin-mocha/catppuccin-latte/' $conf/yazi/theme.toml
fi
