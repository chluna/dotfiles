#!/usr/bin/env bash
#
# Backup script by chluna 20200409
# Needs to be run as 'sudo <dir>/backup.sh'
#

now=$(date +"%Y%m%d-%H%M")
dest1="/run/media/spike/ssd/backups/$now"
dest2="/home/spike/OneDrive/me/tech/linux/manjaro-xfce/backups/$now"
arg="-aqh"

mkdir -p $dest1
echo "Back up to external drive:"
for dir in \
   "/home/spike/OneDrive/" \
   "/home/spike/.config/" \
   "/home/spike/.ssh/" \
   "/home/spike/backup.sh" \
   "/home/spike/.bashrc" \
   "/home/spike/.bash_profile" \
   "/home/spike/.zshrc" \
   "/home/spike/.zprofile" \
   "/home/spike/.zsh/" \
   "/home/spike/.p10k.zsh" \
   "/usr/share/lightdm-webkit/themes/" \
   "/usr/share/themes/lightdm-gtk-clearlooks-grey/" \
   "/usr/share/themes/McOS-MJV-Dark-XFCE-Edition-2.3/" \
   "/usr/share/icons/McMojave-circle/" \
   "/usr/share/icons/McMojave-circle-dark/" \
   "/usr/share/icons/McMojave-circle-grey/" \
   "/usr/share/icons/McMojave-circle-grey-dark/" \
   "/etc/lenovo_fix.conf"
do
   echo "Copying" $dir
   if [[ "$dir" == */ ]]; then
      mkdir -p $dest1$dir
   else
      mkdir -p $dest1$(dirname $dir)
   fi
   rsync $arg --log-file=$dest1/$now.log $dir $dest1$dir
done
echo "Backup saved in" $dest1

echo ""

mkdir -p $dest2
echo "Backup to OneDrive:"
for dir in \
   "/home/spike/.config/" \
   "/home/spike/.ssh/" \
   "/home/spike/backup.sh" \
   "/home/spike/.bashrc" \
   "/home/spike/.bash_profile" \
   "/home/spike/.zshrc" \
   "/home/spike/.zprofile" \
   "/home/spike/.zsh/" \
   "/home/spike/.p10k.zsh" \
   "/etc/lenovo_fix.conf"
do
   echo "Copying" $dir
   if [[ "$dir" == */ ]]; then
      mkdir -p $dest2$dir
   else
      mkdir -p $dest2$(dirname $dir)
   fi
   rsync $arg --log-file=$dest2/$now.log $dir $dest2$dir
done
echo "Backup saved in" $dest2
