#!/bin/bash

socket=$(ss -ax | rg @kittysock | xargs | cut -d ' ' -f 5)
conf=$HOME/.config

if [[ "$XFCE_NIGHT_MODE" == "night" ]]; then
  xfconf-query --channel xfce4-panel --property /panels/dark-mode --type bool --set true
  command -v kitty >/dev/null && kitten @ --to unix:"$socket" kitten themes --reload-in=all Catppuccin-Mocha
  [[ -f "$conf"/bat/config ]] && sed -i 's/Catppuccin Latte/Catppuccin Mocha/' "$conf"/bat/config
  [[ -f "$conf"/btop/btop.conf ]] && sed -i 's/catppuccin_latte/catppuccin_mocha/' "$conf"/btop/btop.conf
  [[ -f "$conf"/git/config ]] && sed -i 's/catppuccin-latte/catppuccin-mocha/' "$conf"/git/config
  [[ -f "$conf"/helix/config.toml ]] && sed -i 's/catppuccin_latte/catppuccin_mocha/' "$conf"/helix/config.toml
  [[ -f "$conf"/rofi/config.rasi ]] && sed -i 's/catppuccin-latte/catppuccin-mocha/' "$conf"/rofi/config.rasi
  [[ -f "$conf"/yazi/theme.toml ]] && sed -i 's/catppuccin-latte/catppuccin-mocha/' "$conf"/yazi/theme.toml
  [[ -f "$conf"/wezterm/wezterm.lua ]] && sed -i 's/Catppuccin Latte/Catppuccin Mocha/' "$conf"/wezterm/wezterm.lua
  if [[ -f "$conf"/xfce4/genmon/battery.sh ]]; then
    sed -i 's/black/white/' "$conf"/xfce4/genmon/battery.sh
    xfce4-panel --plugin-event=genmon-3:refresh:bool:true
  fi
elif [[ "$XFCE_NIGHT_MODE" = "day" ]]; then
  xfconf-query --channel xfce4-panel --property /panels/dark-mode --type bool --set false
  command -v kitty >/dev/null && kitten @ --to unix:"$socket" kitten themes --reload-in=all Catppuccin-Latte
  [[ -f "$conf"/bat/config ]] && sed -i 's/Catppuccin Mocha/Catppuccin Latte/' "$conf"/bat/config
  [[ -f "$conf"/btop/btop.conf ]] && sed -i 's/catppuccin_mocha/catppuccin_latte/' "$conf"/btop/btop.conf
  [[ -f "$conf"/git/config ]] && sed -i 's/catppuccin-mocha/catppuccin-latte/' "$conf"/git/config
  [[ -f "$conf"/helix/config.toml ]] && sed -i 's/catppuccin_mocha/catppuccin_latte/' "$conf"/helix/config.toml
  [[ -f "$conf"/rofi/config.rasi ]] && sed -i 's/catppuccin-mocha/catppuccin-latte/' "$conf"/rofi/config.rasi
  [[ -f "$conf"/yazi/theme.toml ]] && sed -i 's/catppuccin-mocha/catppuccin-latte/' "$conf"/yazi/theme.toml
  [[ -f "$conf"/wezterm/wezterm.lua ]] && sed -i 's/Catppuccin Mocha/Catppuccin Latte/' "$conf"/wezterm/wezterm.lua
  if [[ -f "$conf"/xfce4/genmon/battery.sh ]]; then
    sed -i 's/white/black/' "$conf"/xfce4/genmon/battery.sh
    xfce4-panel --plugin-event=genmon-3:refresh:bool:true
  fi
fi
