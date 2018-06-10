distro_pkgs=pideck, xwax, usbmount, jackd2, cdparanoia, ffmpeg, mpg123, id3v2, flac, vorbis-tools

all: clean local image

.PHONY: clean
clean:
	rm -rf repo/ tmp/ local.xml


.PHONY: local
local:
	pdk abstract --arch=armhf --packages="$(distro_pkgs)" local.xml
	pdk resolve local.xml


.PHONY: image
image:
	pdk download pideck.xml
	pdk closure --out-file=local.xml --arch=armhf pideck.xml local.xml
	pdk repogen pideck.xml
	sudo pdk mediagen pideck.xml
