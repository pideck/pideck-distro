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
- Ignore the `rng-tools` service failing to start with "Cannot find a hardware RNG device to use." You won't need this to run as a service for now

## APT Repository key

- Make the APT repository email apt@your-domain
- To enable automated builds later, either do not set a passphrase when you generate the key (less secure), or automate signing with [gpg-preset-passphrase](https://www.gnupg.org/documentation/manuals/gnupg/gpg_002dpreset_002dpassphrase.html) running on each boot. You will be prompted twice for the passphrase, if any.

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
- You only need to `pdk download pideck.xml` again if you have added packages in your modifications

## Build image

```bash
make image
```
- This step uses `sudo`, you will be prompted for your login password as well as your GnuPG passphrase, if you are using one.

- After some time, you should find the _out.img_ file in your PDK workspace.

- Use the `lsblk` command to identify the device of your microSD card writer before and after plugging it in, such as `/dev/sdb` in the example below. If you get this device wrong, you could wipe your hard disk, so please be careful.

-  Copy the image you created to a microSD card using the `dd` command (the status=progress option is helpful). After `dd` has completed, use the `sync` command before unplugging:

```bash
sudo dd status=progress bs=4M if=tmp/out.img of=/dev/sdb conv=fsync
sync
``` 

- Or try [bmap-tools](https://packages.debian.org/search?keywords=bmap-tools) to create checksums for your image and potentially make it easier to deploy. Your users may prefer using [Etcher](https://etcher.io/) which is a GUI program.

Please see the [PDK project on GitHub](https://github.com/64studio/pdk) for more details of how to use PDK.
