echo "#Ubuntu 10.10 Maverick Meerkat

To enable USB Tethering just install the ipheth-utils package.

Amarok

Due to changes in some libraries, Amarok is unable to properly work with iPhone or iPod Touch devices, displaying a generic "Apple iPhone/iPod" name and zero tracks instead of the actual properties of the device, and failing to add new tracks.

This problem (and many others) is fixed in the KDE 4.6 release, which you can install from the Kubuntu Backports PPA, like this:
"
sudo add-apt-repository ppa:kubuntu-ppa/backports
sudo apt-get update && sudo apt-get upgrade

echo "Note that this will update all of your KDE programs--and any others with a pending update.

If you don't want to update, you can revert the problem libraries to Lucid as a workaround (as found in the bug report), keeping in mind not to update them in subsequent system updates (automatic updates will try to get the new versions of the packages, even flagged as hold).

The easy way is to download the package files and install them:

$ "

mkdir /tmp/packages && cd /tmp/packages

 wget -nc -c http://archive.ubuntu.com/ubuntu/pool/main/{libi/libimobiledevice/libimobiledevice0_0.9.7-1ubuntu1,libm/libmtp/libmtp-dev_1.0.2-1ubuntu1,libm/libmtp/libmtp8_1.0.2-1ubuntu1,libu/libusb/libusb-0.1-4_0.1.12-14ubuntu0.2,libu/libusb/libusb-dev_0.1.12-14ubuntu0.2}_`dpkg --print-architecture`.deb

 sudo dpkg --install *.deb

 sudo apt-get hold libmtp8 libmtp-dev libusb-dev libusb-0.1-4

echo "Advanced users, however, may want to do it \"the right way\", adding Lucid and Lucid Updates repositories to your install sources (while pinning your system to Maverick in your apt.conf) and installing with the standard apt:

$ "
read readline

sudo apt-get install libmtp8/lucid libmtp-dev/lucid libimobiledevice0/lucid libusb-dev/lucid-updates libusb-0.1-4/lucid-updates

 sudo apt-get hold libmtp8 libmtp-dev libusb-dev libusb-0.1-4

echo "This will make sure you get the latest versions, in case there are updates. Whichever way you install them, restart your session afterwards for Amarok to finally recognize your device correctly.

Note that the progress bar might still not work while transferring something to your device. If it stays at 0%, let it be, most probably it is copying your songs anyway. After the files have been transferred, Amarok will proceed to update your iTunes database, at which point your device will signal so with the usual "Syncronizing" screen. When that screen is gone, your songs should be in your music player, even if Amarok is still stuck at 0%...


"


read readline


