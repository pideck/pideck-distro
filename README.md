# PDK Project for PiDeck Custom Distro

PDK is the Platform Development Kit that we use for creating the [PiDeck](http://pideck.com) distro image, based on Debian GNU/Linux. To download PiDeck, please see the [releases](https://github.com/pideck/pideck-distro/releases) page.

## Install PDK

```bash
sudo apt install apt-transport-https
echo "deb https://apt.64studio.net stretch main" | sudo tee /etc/apt/sources.list.d/64studio.list
wget -qO - https://apt.64studio.net/archive-keyring.asc | sudo apt-key add -
sudo apt update
sudo apt install pdk pdk-mediagen rng-tools
```
(ignore service failing to start with "Cannot find a hardware RNG device to use.")

## APT Repository key

- Make email apt@your-domain
- Do not set a passphrase (you will be prompted twice)

```bash
sudo rngd -r /dev/urandom
gpg --gen-key
```

## Download PDK project 'PiDeck'

```bash
pdk workspace create pideck
cd pideck/
git remote add github https://github.com/pideck/pideck-distro.git
git pull github master
pdk channel update
pdk pull components
make local
pdk download pideck.xml
```

## Modify apt-deb.key email address to your own

```bash
nano pideck.xml
```

## Optional - modify project Makefile, modify postinst script

```bash
nano Makefile
nano postinst.sh
make local
pdk download pideck.xml
pdk commit -m "A note about my changes"
```
- You only need to download pideck.xml again if you have added packages in your modifications

## Build image

```bash
make image
```
- This step uses sudo, you will be prompted for your login password

- After some time, you should find the .img file in the tmp/ directory of your PDK workspace

- You can copy this image to a microSD card using dd (the status=progress option is helpful):

`sudo dd status=progress bs=4M if=tmp/out.img of=/dev/sdb conv=fsync` 

- Or try [bmap-tools](https://packages.debian.org/search?keywords=bmap-tools) to create checksums for your image and potentially make it easier to deploy

Please see the [PDK project on GitHub](https://github.com/64studio/pdk) for more details of how to use PDK.
