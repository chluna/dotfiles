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

# Symlink .xprofile to .profile
ln -s /home/spike/.xprofile /home/spike/.profile

# ----------
#    ROOT
# ----------

# Set source directory of root configuration files
root="$(chezmoi source-path)/root"

# Symlink user configurations to root
sudo ln -sf /home/spike/.zshenv /root/.zshenv
sudo ln -sf $ZDOTDIR /root/.config/
sudo ln -sf /home/spike/.config/helix/ /root/.config/

# Copy configuration files to corresponding directories in /etc
sudo cp "$root"/etc/btrbk/btrbk.conf /etc/btrbk/
sudo cp "$root"/etc/greetd/config.toml /etc/greetd/
sudo cp "$root"/etc/NetworkManager/dispatcher.d/99-update-genmon-network.sh /etc/NetworkManager/dispatcher.d/
sudo cp "$root"/etc/systemd/system/* /etc/systemd/system/
sudo cp "$root"/etc/pacman.conf /etc/
sudo cp "$root"/etc/throttled.conf /etc/

# Enable and start systemd services
sudo systemctl enable greetd.service
sudo systemctl enable sxlock.service
sudo systemctl enable --now battery-charge-start-threshold@75
sudo systemctl enable --now battery-charge-stop-threshold@80

# Enable and start systemd timers
sudo systemctl enable --now archlinux-keyring-wkd-sync.timer

# Configure NetworkManager-dispatcher genmon script
sudo chown root:root /etc/NetworkManager/dispatcher.d/99-update-genmon-network.sh
sudo chmod 755 /etc/NetworkManager/dispatcher.d/99-update-genmon-network.sh
sudo systemctl enable --now NetworkManager-dispatcher.service
