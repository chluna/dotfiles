#!/bin/ash

# set ZDOTDIR
ZDOTDIR=~/.config/zsh
mkdir -p $ZDOTDIR

# download from gitlab
wget https://gitlab.com/.chluna/dotfiles/-/raw/master/ish/zshenv_ish
mv ~/zshenv_ish ~/.zshenv
wget https://gitlab.com/.chluna/dotfiles/-/raw/master/ish/zshrc_ish
mv ~/zshrc_ish $ZDOTDIR/.zshrc

# update apk repositories
[[ $(cat /ish/version) -lt 88 ]] && echo 'file:///ish/apk/community' >> /etc/apk/repositories 
apk update
apk add curl git nano neofetch zsh
apk info zsh >/dev/null
[[ $(echo $?) -eq 0 ]] && sed -i 's/\/bin\/ash/\/bin\/zsh/g' /etc/passwd

# clone zsh themes and plugins
git clone https://github.com/sindresorhus/pure.git $ZDOTDIR/pure
git clone https://github.com/zsh-users/zsh-autosuggestions $ZDOTDIR/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZDOTDIR/zsh-syntax-highlighting

# clear /etc/motd
echo '' > /etc/motd

# restart in zsh
reset
exec zsh