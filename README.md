# ~/.dotfiles/

My personal dotfiles repository.

__Linux:__

* [btop](https://github.com/aristocratos/btop) - resource monitor
* [btrbk](https://digint.ch/btrbk/) - backup tool for btrfs subvolumes
* [git](https://git-scm.com/) - distributed version control system
* [helix](https://helix-editor.com/) - a post-modern text editor
* [keepassxc](https://github.com/keepassxreboot/keepassxc) - password manager based on Keepass
* [kitty](https://sw.kovidgoyal.net/kitty/) - GPU-based terminal emulator
* [neovim](https://neovim.io/) - hyperextensible Vim-based text editor
* [nnn](https://github.com/jarun/nnn) - terminal file manager
* [onedrive](https://abraunegg.github.io/) - a free Microsoft OneDrive client for Linux
* [paru](https://github.com/Morganamilo/paru) - AUR helper
* [redshift](http://jonls.dk/redshift) - color temperature adjuster for screens at night
* [rofi](https://github.com/davatorium/rofi) - window switcher, application launcher and dmenu replacement
* [vscodium](https://vscodium.com) - Visual Studio Code sans Microsoft branding/licensing/telemetry
* [wezterm](https://wezfurlong.org/wezterm/) - GPU-accelerated cross-platform terminal emulator and multiplexer written in Rust
* `genmon/` - scripts for [xfce4-genmon-plugin](https://docs.xfce.org/panel-plugins/xfce4-genmon-plugin)
* `xfce`/ - [Xfce](https://xfce.org/) related configurations
* `zsh/` - [z shell](https://www.zsh.org/) with [Powerlevel10k theme](https://github.com/romkatv/powerlevel10k)

---

__Setting up dotfiles using [dotbot](https://github.com/anishathalye/dotbot)__ [^1]

```shell
% sudo pacman -S git zsh python # install if not yet installed

# clone from remote
% git clone https://gitlab.com/.chluna/dotfiles.git ~/.config/.dotfiles --recursive
% cd ~/.config/dotfiles
% micro user.conf.yaml # edit user config file
% micro root.conf.yaml # edit root config file
% ./install

# pulling changes from remote
% cd ~/.config/dotfiles
% git pull
% ./install
```
[^1]: This is the [tutorial](https://www.elliotdenolf.com/posts/bootstrap-your-dotfiles-with-dotbot) I used to initially set this up.
