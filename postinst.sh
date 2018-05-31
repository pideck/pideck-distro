#!/usr/bin/env bash

# TODO: make this quit if run on host machine. oops!

# TODO: install packages elsewhere
apt-get install rpi-stock-kernel-firmware sudo alsa-utils rt-tests psmisc cpufrequtils console-common fake-hwclock ntp xserver-xorg xserver-xorg-video-fbdev xserver-xorg-input-libinput dbus-x11 policykit-1 lxde-core lightdm lxterminal jackd2 cdparanoia ffmpeg mpg123 id3v2 flac vorbis-tools xwax pideck usbmount whois --yes

# create user
USERNAME="pi"
ENCRYPTED_PASSWORD=`mkpasswd -m sha-512 "deck"`
adduser --gecos $USERNAME --add_extra_groups --disabled-password $USERNAME
chown $USERNAME:$USERNAME /home/$USERNAME
usermod -aG audio $USERNAME
usermod -aG sudo $USERNAME
usermod -p "${ENCRYPTED_PASSWORD}" $USERNAME

# kernel cmdline
echo "dwc_otg.lpm_enable=0 net.ifnames=0 console=ttyAMA0,115200 root=/dev/mmcblk0p2 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait logo.nologo" > /boot/cmdline.txt

# autologin
sed -i "s/^#autologin-user=/autologin-user=$USERNAME/" /etc/lightdm/lightdm.conf

# no cursor & no screensaver
sed -i "s/^#xserver-command=X/xserver-command=X -s 0 -dpms -nocursor/" /etc/lightdm/lightdm.conf

# remove the rainbow splash screen at bootup
echo "disable_splash=1" >> /boot/config.txt

# remove the console login that flashes before X starts
systemctl disable getty@tty1

# add the soundcard module
echo "dtoverlay=audioinjector-wm8731-audio" >> /boot/config.txt

# set CPUs to no throttling
sed -i 's/^GOVERNOR=.*/GOVERNOR="performance"/' /etc/init.d/cpufrequtils

# disable bluetooth
echo "dtoverlay=pi3-disable-bt" >> /boot/config.txt
