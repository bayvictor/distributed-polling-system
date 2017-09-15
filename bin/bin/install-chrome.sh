apt-get  install -y libtool 
apt-get update
apt-get -f install
dpkg --configure -a

sudo apt-get install -y chromium-browser

apt-get install -y -y gtk2-engines-pixbuf
apt-get install -y -y      sysv-rc
apt-get install -y -y      libnss3-dev
apt-get install -y -y      libasound2-dev
apt-get install -y -y      libgconf-dbus-dev
apt-get install -y -y      libgtk2.0-dev
apt-get install -y -y      libbz2-dev

apt-get install -y -y      libjpeg7-dev
apt-get install -y -y      libjpeg8-dev
apt-get install -y -y      libpam0g-dev
apt-get install -y -y      mesa-common-dev
apt-get install -y -y      libgl1-mesa-dev
apt-get install -y -y      libglu1-mesa-dev
apt-get install -y -y      libxss-dev
apt-get install -y -y      libgnome-keyring-dev
apt-get install -y -y      pkg-config
apt-get install -y -y      libglib2.0-dev
apt-get install -y -y      libnspr4-0d 
apt-get install -y -y      libnspr4-dev
apt-get install -y -y      libfreetype6-dev
apt-get install -y -y       libcairo2-dev
apt-get install -y -y       libdbus-1-dev
apt-get install -y -y       libexpat1-dev



apt-get update
apt-get -f install
dpkg --configure -a



echo "^C to break, any key to do dpkg --force-overwrite -i xxx-armel.deb"


read read_line
dpkg --force-overwrite -i  /var/cache/apt/archives/debianutils_2.30_armel.deb
 apt-get  install -y autoconf
  apt-get install -y -y automake
 dpkg --force-overwrite -i   /var/cache/apt/archives/libgmp3c2_2%3a4.2.2+dfsg-3_armel.deb



ls /home/vhuang/src/bzlib/bzip2-1.0.5
cd /home/vhuang/src/bzlib/bzip2-1.0.5
cp libbz2.* /opt/media/local/lib

dpkg --force-overwrite -i  /var/cache/apt/archives/perl-base_5.10.0-19lenny3_armel.deb

 dpkg --force-overwrite -i  /var/cache/apt/archives/libdbus-1-3_1.2.1-5+lenny1_armel.deb

 
 
apt-get update
apt-get -f install
dpkg --configure -a


 
 echo 'after this, you must still want to compile & install -y '
echo "1).ld-gold;2).subversion1.6;3).git1.7; 4)gclient/depot-tools;5)"

cd ~/src/nss-3.12.8
armconf

cd ~/src/redhat_gdbserver/redhat_gdbserver/gdb-7.2
armconf

cd ~/src/git-1.7.1
armconf

cd ~/src/libvpx-0.9.5
armconf

cd ~/src/python2.7-2.7
make install

cd ~/src/alsa-lib-1.0.16
make install

cd ~/bzlib/bzip2-1.0.5
make install

cp ~/src/gold/binutils-2.21/ld/ld-new /opt/media/local/bin
cd ~/src/gold/binutils-2.21
armconf

cd ~/src/findutils-4.4.0
armconf

cd ~/src/libuuid/util-linux-ng-2.17.2/
armconf




#sudo apt-get install -y -y git-core
