#!/bin/sh

# ----------
#    USER
# ----------

# Reload zsh config
exec zsh

# Reload font cache
fc-cache -f -v

# Disable CapsLock globally using localectl
localectl set-x11-keymap "" "" "" caps:none

# ----------
#    ROOT
# ----------

# Set source directory of root configuration files
root="$(chezmoi source-path)/root"

# Symlink user configurations to root
sudo ln -sf /home/spike/.zshenv /root/.zshenv
sudo ln -sf $ZDOTDIR /root/.config
sudo ln -sf /home/spike/.config/helix/ /root/.config

# Copy configuration files to corresponding directories in /etc
sudo cp "$root"/etc/btrbk/btrbk.conf /etc/btrbk
sudo cp "$root"/etc/lightdm/web-greeter.yml /etc/lightdm
sudo cp "$root"/etc/NetworkManager/dispatcher.d/99-update-genmon-network.sh /etc/NetworkManager/dispatcher.d/
sudo cp "$root"/etc/pacman.conf /etc/
sudo cp "$root"/etc/throttled.conf /etc/

# Configure NetworkManager-dispatcher genmon script
sudo chown root:root /etc/NetworkManager/dispatcher.d/99-update-genmon-network.sh
sudo chmod 755 /etc/NetworkManager/dispatcher.d/99-update-genmon-network.sh
sudo systemctl enable --now NetworkManager-dispatcher.service
