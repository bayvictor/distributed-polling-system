sudo apt-get install alsa-utils --reinstall
mkdir ~/src/alsalib
cd  ~/src/alsalib
wget https://launchpad.net/ubuntu/+archive/primary/+files/alsa-lib_1.0.25.orig.tar.bz2
tar -jxf alsa-lib_1.0.25.orig.tar.bz2
cd alsa*
./configure
make
sudo make install

