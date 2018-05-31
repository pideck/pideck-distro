distro_pkgs=pideck, xwax, usbmount, jackd2, cdparanoia, ffmpeg, mpg123, id3v2, flac, vorbis-tools

all: clean closure image

.PHONY: clean
clean:
	rm -rf repo/ tmp/ pideck-closure.xml


.PHONY: closure
closure:
	pdk abstract --arch=armhf --packages="$(distro_pkgs)" pideck-closure.xml
	pdk resolve pideck-closure.xml
	pdk closure --out-file=pideck-closure.xml --arch=armhf pideck.xml pideck-closure.xml


.PHONY: image
image:
	pdk repogen pideck.xml
	sudo pdk mediagen pideck.xml
