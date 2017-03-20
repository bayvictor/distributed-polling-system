sudo deb http://ppa.launchpad.net/kubuntu-ppa/beta/ubuntu karmic main
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get install -y kubuntu-desktop



sudo apt-get install -y libqt4-phonon-dev
sudo apt-get install -y kdelibs5-dev kdepimlibs5-dev
cmake -DCMAKE_INSTALL_PREFIX=`kde4-config` .  #/phononnamespace.h
