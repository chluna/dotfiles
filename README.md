# ~/.dotfiles/

My personal dotfiles repository.

__Linux:__

* [alacritty](https://github.com/alacritty/alacritty) - terminal emulator
* [git](https://git-scm.com/) - free and open source distributed version control system
* [keepassxc](https://github.com/keepassxreboot/keepassxc) - password manager based on Keepass
* [nnn](https://github.com/jarun/nnn) - terminal file manager
* [onedrive](https://github.com/abraunegg/onedrive) - OneDrive client
* [paru](https://github.com/Morganamilo/paru) - AUR helper based on yay
* [redshift](http://jonls.dk/redshift) - color temperature adjuster for screens at night
* [rofi](https://github.com/davatorium/rofi) - window switcher, application launcher and dmenu replacement
* [vscodium](https://vscodium.com) - Visual Studio Code sans Microsoft branding/licensing/telemetry
* `genmon/` - scripts for [xfce4-genmon-plugin](https://docs.xfce.org/panel-plugins/xfce4-genmon-plugin)
* `zsh/` - [z shell](https://www.zsh.org/) with [Powerlevel10k theme](https://github.com/romkatv/powerlevel10k)

__iOS:__

* zsh for [ish](https://ish.app/) - Alpine Linux on iOS, using a usermode x86 emulator

---

__Setting up dotfiles using [dotbot](https://github.com/anishathalye/dotbot)__ [^1]

```shell
% sudo pacman -S git zsh python # install if not yet installed

# clone from remote
% git clone git@gitlab.com:.chluna/dotfiles.git ~/.config/.dotfiles --recursive
% cd ~/.config/dotfiles
% micro install.conf.yaml # edit config file
% ./install

# pulling changes from remote
% cd ~/.config/dotfiles
% git pull
% ./install
```
[^1]: This is the [tutorial](https://www.elliotdenolf.com/posts/bootstrap-your-dotfiles-with-dotbot) I used to initially set this up.
