#!/bin/sh

# ----------
#    USER
# ----------

# Reload fish config
exec fish

# Reload font cache
fc-cache -f -v

# Symlink .profile to .xprofile
ln -sf /home/spike/.profile /home/spike/.xprofile

# ----------
#    ROOT
# ----------

# Set source directory of root configuration files
root="$(chezmoi source-path)/root"

# Symlink user configurations to root
sudo ln -sf /home/spike/.env /root/
sudo ln -sf /home/spike/.profile /root/
sudo ln -sf /home/spike/.config/fastfetch/ /root/.config/
sudo ln -sf /home/spike/.config/fish /root/.config/
sudo ln -sf /home/spike/.config/helix/ /root/.config/
sudo ln -sf /home/spike/.config/yazi /root/.config/

# Copy configuration files to corresponding directories in /etc
sudo cp "$root"/etc/greetd/config.toml /etc/greetd/
sudo cp "$root"/etc/NetworkManager/dispatcher.d/99-update-genmon-network.sh /etc/NetworkManager/dispatcher.d/
sudo cp "$root"/etc/systemd/system/* /etc/systemd/system/
sudo cp "$root"/etc/auto-cpufreq.conf /etc/
sudo cp "$root"/etc/pacman.conf /etc/
sudo cp "$root"/etc/throttled.conf /etc/

# Enable and start systemd services
systemctl --user enable --now onedrive.service
systemctl --user enable --now psd.service
systemctl --user enable --now redshift-gtk.service
sudo systemctl enable greetd.service
sudo systemctl enable --now auto-cpufreq.service
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now NetworkManager.service
sudo systemctl enable --now throttled.service
sudo systemctl enable --now libvirtd.socket
sudo systemctl enable --now virtlogd.socket

# Enable and start systemd timers
sudo systemctl enable --now archlinux-keyring-wkd-sync.timer
sudo systemctl enable --now btrbk.timer
sudo systemctl enable --now fwupd-refresh.timer

# Configure NetworkManager-dispatcher genmon script
sudo chown root:root /etc/NetworkManager/dispatcher.d/99-update-genmon-network.sh
sudo chmod 755 /etc/NetworkManager/dispatcher.d/99-update-genmon-network.sh
sudo systemctl enable --now NetworkManager-dispatcher.service
