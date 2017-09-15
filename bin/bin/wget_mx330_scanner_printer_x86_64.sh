sudo apt-get install -y libsane #- API library for scanners
sudo apt-get install -y simple-scan #- Simple Scanning Utility
sudo apt-get install -y sane #- scanner graphical frontends
sudo apt-get install -y xsane #- featureful graphical frontend for SANE (Scanner Access Now Easy)
sudo apt-get install -y xsane-common #- featureful graphical frontend for SANE (Scanner Access Now Easy)
echo "^C to break, anykey to wget scanner driver ..."
read readline




wget https://launchpad.net/~michael-gruz/+archive/canon-trunk/+files/cnijfilter-common_3.80-28~oneiric1_amd64.deb
wget https://launchpad.net/~michael-gruz/+archive/canon-trunk/+files/cnijfilter-mx360series_3.80-28~oneiric1_amd64.deb
wget https://launchpad.net/~michael-gruz/+archive/canon-trunk/+sourcepub/2975390/+listing-archive-extra


sudo apt-get -f install

sudo apt-get install -y git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev  lib32ncurses5 lib32z1 x11proto-core-dev libx11-dev  lib32z-dev

sudo dpkg -i --force-architecture cnijfilter-common_3.10-1_i386.deb
sudo dpkg -i --force-architecture cnijfilter-mx330series_3.10-1_i386.deb
sudo dpkg -i --force-architecture scangearmp-common_1.30-1_i386.deb
sudo dpkg -i --force-architecture scangearmp-mx330series_1.30-1_i386.deb


