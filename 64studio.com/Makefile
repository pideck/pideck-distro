components=minimal.xml rpi.xml python.xml sshd.xml sudo.xml nano.xml usbmount.xml xorg.xml lxde.xml lightdm.xml lxterminal.xml iceweasel.xml alsa.xml alsamixergui.xml jackd2.xml qjackctl.xml xwax.xml pideck.xml

# minimal.xml
#
# packages required to install a basic Debian system
#
minimal_pkgs=
minimal_exclude=

# rpi.xml: packages required to use the rpi build script
rpi_deps=minimal.xml
rpi_pkgs=git-core, binutils, ca-certificates, e2fsprogs, curl, fake-hwclock, ntp, console-common, locales, aptitude, debconf-utils, cpufrequtils, firmware-rpi, linux-image-rpi
rpi_exclude=

#
# Libs
#

python_deps=minimal.xml
python_pkgs=python
python_exclue=

#
# Admin Tools
#

# sshd.xml: OpenSSH server
sshd_deps=minimal.xml
sshd_pkgs=openssh-server
sshd_exclude=

# sudo.xml: Sudo
sudo_deps=minimal.xml
sudo_pkgs=sudo
sudo_exclude=

# nano.xml: Text Editor
nano_deps=minimal.xml
nano_pkgs=nano
nano_exclude=

# usbmount.xml: Automount USBs
usbmount_deps=minimal.xml
usbmount_pkgs=usbmount
usbmount_exclude=

#
# Desktop Environment
#


# xorg.xml: Xorg server (do we need xinit?)
xorg_deps=minimal.xml
xorg_pkgs=xserver-xorg, xserver-xorg-video-fbdev, dbus-x11, policykit-1
xorg_exclude=

# lxde.xml: LXDE Leightweight Desktop Env
lxde_deps=minimal.xml xorg.xml
lxde_pkgs=lxde-core
lxde_exclude=

# lightdm.xml: leightweight window manager
lightdm_deps=minimal.xml xorg.xml
lightdm_pkgs=lightdm
lightdm_exclude=

# lxterminal.xml: terminal for LXDE
lxterminal_deps=minimal.xml xorg.xml lxde.xml
lxterminal_pkgs=lxterminal
lxterminal_exclude=

# iceweasel.xml: web browser
iceweasel_deps=minimal.xml xorg.xml lxde.xml
iceweasel_pkgs=iceweasel
iceweasel_exclude=


#
# Audio Applications
#


# alsa.xml: Linux Audio
alsa_deps=minimal.xml
alsa_pkgs=alsa-oss,alsa-utils
alsa_exclude=

# alsamixergui.xml: Linux Audio
alsamixergui_deps=minimal.xml alsa.xml xorg.xml lxde.xml
alsamixergui_pkgs=alsamixergui
alsamixergui_exclude=

# jackd2.xml: JACKD2 Audio Server
jackd2_deps=minimal.xml python.xml alsa.xml
jackd2_pkgs=jackd2
jackd2_exclude=

# qjackctl.xml: JACK
qjackctl_deps=minimal.xml python.xml alsa.xml xorg.xml lxde.xml jackd2.xml
qjackctl_pkgs=qjackctl
qjackctl_exclude=

# xwax.xml: Xwax Vinyl Emulation
xwax_deps=minimal.xml alsa.xml
xwax_pkgs=xwax,libav-tools,mpg123,cdparanoia,id3v2,flac,vorbis-tools
xwax_exclude=

pideck_deps=minimal.xml alsa.xml jackd2.xml xwax.xml
pideck_pkgs=pideck
pideck_exclude=

#realtime.xml: Support for realtime kernels
#realtime_deps=minimal.xml
#realtime_pkgs=rtirq-init
#realtime_exclude=

#
# do not edit past here
#

all: update components download

clean:
	rm -f *.xml

update:
	pdk channel update

components: $(components)

minimal.xml:
	pdk abstract --arch=armhf --packages="$(minimal_pkgs)" --select="Priority: required,important" --exclude="$(minimal_exclude)" --label="minimal" minimal.xml
	pdk resolve minimal.xml
	pdk closure --out-file=minimal.xml --arch=armhf minimal.xml
	pdk upgrade minimal.xml

%.xml:
	pdk abstract --arch=armhf --packages="$($*_pkgs)" --exclude="$($*_exclude)" --meta="<task>cdd</task>" --label="$*" $@
	pdk resolve $@
	pdk closure --out-file=$@ --arch=armhf $($*_deps) $@
	pdk upgrade $@

download:
	pdk download $(components)

