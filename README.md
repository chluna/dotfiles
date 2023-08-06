# dotfiles

My personal dotfiles repository.

__Arch Linux on Lenovo ThinkPad T480__

* [bspwm](https://github.com/baskerville/bspwm) - tiling window manager based on binary space partitioning 
* [btop](https://github.com/aristocratos/btop) - resource monitor
* [btrbk](https://digint.ch/btrbk/) - backup tool for btrfs subvolumes
* [fastfetch](https://github.com/LinusDierheimer/fastfetch) - like neofetch, but much faster
* [feh](https://feh.finalrewind.org/) - a fast and light image viewer
* [fish](https://fishshell.com/) with [tide theme](https://github.com/IlanCosman/tide)
* [git](https://git-scm.com/) - distributed version control system
* [helix](https://helix-editor.com/) - a post-modern text editor
* [kitty](https://sw.kovidgoyal.net/kitty/) - GPU-based terminal emulator
* [neovim](https://neovim.io/) - hyperextensible Vim-based text editor
* [nnn](https://github.com/jarun/nnn) - terminal file manager
* [onedrive](https://abraunegg.github.io/) - a free Microsoft OneDrive client for Linux
* [paru](https://github.com/Morganamilo/paru) - AUR helper
* [picom](https://github.com/yshui/picom) - a lightweight compositor for X11
* [redshift](http://jonls.dk/redshift) - color temperature adjuster for screens at night
* [rofi](https://github.com/davatorium/rofi) - window switcher, application launcher and dmenu replacement
* [sxhkd](https://github.com/baskerville/sxhkd) - Simple X hotkey daemon
* [tuigreet](https://github.com/apognu/tuigreet) - graphical console greeter for greetd
* [VSCodium](https://vscodium.com/) - FOSS binaries of Visual Studio Code
* [Xfce](https://xfce.org/) including scripts for [xfce4-genmon-plugin](https://docs.xfce.org/panel-plugins/xfce4-genmon-plugin)
* [zsh](https://www.zsh.org/) with [Powerlevel10k theme](https://github.com/romkatv/powerlevel10k)

---

__Setting up dotfiles using [chezmoi](https://www.chezmoi.io/)__

```shell
% sudo pacman -S chezmoi

# Clone from remote and check which changes chezmoi will make before installing
% chezmoi init https://github.com/chluna/dotfiles.git
% chezmoi diff
% chezmoi apply -v

# Alternatively, clone and install in a single command
% chezmoi init --apply https://github.com/chluna/dotfiles.git

# Pull latest changes from remote
% chezmoi update -v
```
