# dotfiles

My personal `dotfiles` repository.

This features the [fish](https://fishshell.com/) as the interactive shell and uses the [Catppuccin](https://catppuccin.com/) theme on all applications.

## Specifications
| Machine | Operating System | Desktop Environment |
| --- | --- | --- |
| [Apple MacBook Pro](https://www.apple.com/macbook-pro/) | [macOS Tahoe](https://www.apple.com/os/macos/) | --- |
| [Lenovo ThinkPad T480](https://www.thinkwiki.org/wiki/Category:T480) | [Arch Linux](https://archlinux.org/) | [Xfce](https://xfce.org/) |

## Applications
- [bat](https://github.com/sharkdp/bat) - a cat(1) clone with wings
- [btop](https://github.com/aristocratos/btop) - resource monitor
- [fastfetch](https://github.com/LinusDierheimer/fastfetch) - like neofetch, but much faster
- [git](https://git-scm.com/) - distributed version control system
- [helix](https://helix-editor.com/) - a post-modern text editor
- [kitty](https://sw.kovidgoyal.net/kitty/) - GPU-based terminal emulator
- [neovim](https://neovim.io/) - hyperextensible Vim-based text editor
- [VSCodium](https://vscodium.com/) - FOSS binaries of Visual Studio Code
- [WezTerm](https://wezfurlong.org/wezterm/) - a GPU-accelerated cross-platform terminal emulator and multiplexer
- [yazi](https://yazi-rs.github.io/) - blazing fast terminal file manager written in Rust, based on async I/O
- [zsh](https://www.zsh.org/) using the [Powerlevel10k theme](https://github.com/romkatv/powerlevel10k)

### Linux-specific
- [bspwm](https://github.com/baskerville/bspwm) - tiling window manager based on binary space partitioning 
- [btrbk](https://digint.ch/btrbk/) - backup tool for btrfs subvolumes
- [feh](https://feh.finalrewind.org/) - a fast and light image viewer
- [onedrive](https://abraunegg.github.io/) - a free Microsoft OneDrive client for Linux
- [paru](https://github.com/Morganamilo/paru) - AUR helper
- [picom](https://github.com/yshui/picom) - a lightweight compositor for X11
- [redshift](http://jonls.dk/redshift) - color temperature adjuster for screens at night
- [restic](http://restic.net) - a modern backup program
- [rofi](https://github.com/davatorium/rofi) - window switcher, application launcher and dmenu replacement
- [sxhkd](https://github.com/baskerville/sxhkd) - Simple X hotkey daemon
- [tuigreet](https://github.com/apognu/tuigreet) - graphical console greeter for greetd

---

## Setting up dotfiles using [chezmoi](https://www.chezmoi.io/)

```shell
# macOS
brew install chezmoi
# Arch Linux
sudo pacman -S chezmoi

# Clone from remote and check which changes chezmoi will make before installing
chezmoi init https://github.com/chluna/dotfiles.git
chezmoi diff
chezmoi apply -v

# Alternatively, clone and install in a single command
chezmoi init --apply https://github.com/chluna/dotfiles.git

# Pull latest changes from remote
chezmoi update -v
```
