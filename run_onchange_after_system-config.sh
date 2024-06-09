#!/bin/sh

# ----------
#    USER
# ----------

# Reload fish config
exec fish

# Reload font cache
fc-cache -f -v

# Disable CapsLock globally using localectl
localectl set-x11-keymap "" "" "" caps:none

# Symlink .profile to .xprofile
ln -s /home/spike/.profile /home/spike/.xprofile

# ----------
#    ROOT
# ----------

# Set source directory of root configuration files
root="$(chezmoi source-path)/root"

# Symlink user configurations to root
sudo ln -sf /home/spike/.config/fish /root/.config/
sudo ln -sf /home/spike/.config/helix/ /root/.config/
sudo ln -sf /home/spike/.config/fastfetch/ /root/.config/

# Copy configuration files to corresponding directories in /etc
sudo cp "$root"/etc/btrbk/btrbk.conf /etc/btrbk/
sudo cp "$root"/etc/greetd/config.toml /etc/greetd/
sudo cp "$root"/etc/NetworkManager/dispatcher.d/99-update-genmon-network.sh /etc/NetworkManager/dispatcher.d/
sudo cp "$root"/etc/systemd/system/* /etc/systemd/system/
sudo cp "$root"/etc/auto-cpufreq.conf /etc/
sudo cp "$root"/etc/pacman.conf /etc/
sudo cp "$root"/etc/throttled.conf /etc/

# Enable and start systemd services
sudo systemctl enable greetd.service
sudo systemctl enable betterlockscreen@$USER.service
sudo systemctl enable --now auto-cpufreq.service
sudo systemctl enable --now throttled.service

# Enable and start systemd timers
sudo systemctl enable --now archlinux-keyring-wkd-sync.timer
sudo systemctl enable --now btrbk.timer
sudo systemctl enable --now fwupd-refresh.timer
sudo systemctl enable --now reflector.timer

# Configure NetworkManager-dispatcher genmon script
sudo chown root:root /etc/NetworkManager/dispatcher.d/99-update-genmon-network.sh
sudo chmod 755 /etc/NetworkManager/dispatcher.d/99-update-genmon-network.sh
sudo systemctl enable --now NetworkManager-dispatcher.service
