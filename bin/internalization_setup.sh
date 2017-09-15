# This script helps me install -y --force-yes all the needed deb packages in my daily life
# Current version is for Ubuntu 12.04 (Precise Pangolin)


############################ Basic Setup ###############################
sudo apt-get install -y --force-yes ckermit automake -y
sudo apt-get install -y --force-yes cutecom	# just another ckermit
sudo apt-get install -y --force-yes ctags
sudo apt-get install -y --force-yes chmsee -y
sudo apt-get install -y --force-yes rar unrar tree -y
sudo apt-get install -y --force-yes p7zip-full
sudo apt-get install -y --force-yes ascii
sudo apt-get install -y --force-yes dos2unix
sudo apt-get install -y --force-yes bless	# a hex editor
sudo apt-get install -y --force-yes gconf-editor -y	# ubuntu gnome config editor
sudo apt-get install -y --force-yes goldendict -y
sudo apt-get install -y --force-yes goldendict-wordnet
sudo apt-get install -y --force-yes stardict -y

# grant access to /dev/ttyS0 (and friends), needs reboot
sudo adduser `whoami` dialout

sudo apt-get install -y --force-yes leafpad -y
sudo apt-get install -y --force-yes nautilus-open-terminal -y
sudo apt-get install -y --force-yes vim-gnome -y

# lndir
sudo apt-get install -y --force-yes xutils-dev

# lrzsz: free x/y/zmodem implementation
sudo apt-get install -y --force-yes lrzsz

# ime
sudo apt-get install -y --force-yes ibus ibus-pinyin ibus-table-wubi -y

# to fix evince parsing Chinese issue
sudo apt-get install -y --force-yes poppler-data

# Enable Always use location entry in Ubuntu 12.04
gsettings set org.gnome.nautilus.preferences always-use-location-entry true
########################################################################



############################ version control ###########################
sudo apt-get install -y --force-yes git-core -y
sudo apt-get install -y --force-yes git-email -y
sudo apt-get install -y --force-yes gitk -y
sudo apt-get install -y --force-yes subversion -y
########################################################################



############################# BuildYourOwnKernel #######################
# ubuntu linux source
sudo apt-get source linux-image-$(uname -r)

# build environment
sudo apt-get build-dep linux-image-$(uname -r) -y
########################################################################



############################ linux kernel dev ##########################
# make xconfig needs qt
sudo apt-get install -y --force-yes libqt4-dev -y

# make menuconfig need this
sudo apt-get install -y --force-yes libncurses5-dev -y

# a front end reader of trace-cmd output
sudo apt-get install -y --force-yes kernelshark -y
########################################################################



############################ tftp server ###############################
sudo apt-get install -y --force-yes tftp tftpd openbsd-inetd -y
sudo mkdir /tftpboot
sudo chmod -R 777 /tftpboot
sudo chown -R nobody /tftpboot
# need to edit /etc/inetd.conf 
# sudo /etc/init.d/openbsd-inetd restart
sudo apt-get install -y --force-yes openssh-server -y
########################################################################



############################ dhcp server ###############################
sudo apt-get install -y --force-yes dhcpd
# You may want to change the start and end of the IP lease block by
# edit the following config file:
# /etc/udhcpd.conf
#
# default: 192.168.0.20 ~ 192.168.0.254
#
# sudo vi /etc/default/udhcpd
# need to comment the following line
# DHCPD_ENABLED="no"
sudo service udhcpd restart
########################################################################



############################# video program ############################
sudo apt-get install -y --force-yes mplayer -y
sudo apt-get install -y --force-yes smplayer -y

sudo apt-get install -y --force-yes gstreamer0.10-ffmpeg gstreamer0.10-plugins-bad -y
# for asf files
sudo apt-get install -y --force-yes gstreamer0.10-plugins-ugly -y

# Download youtube video
sudo apt-get install -y --force-yes youtube-dl
# update to latest version
sudo youtube-dl -U
########################################################################



############################# android stuff ############################
sudo apt-get install -y --force-yes g++ -y
sudo apt-get install -y --force-yes bison flex gperf -y
sudo apt-get install -y --force-yes zlib1g-dev libssl-dev -y
sudo apt-get install -y --force-yes libglib2.0-dev -y

# fix build ics on precise
# sudo apt-get install -y --force-yes gcc-4.4 g++-4.4 -y
# sudo ln -fs /usr/bin/gcc-4.4 /usr/bin/gcc
# sudo ln -fs /usr/bin/g++-4.4 /usr/bin/g++
########################################################################



############################## FreetuxTV ###############################
sudo apt-get install -y --force-yes intltool libcurl4-openssl-dev -y
sudo apt-get install -y --force-yes libvlc-dev libgtk2.0-dev libdbus-glib-1-dev -y
sudo apt-get install -y --force-yes libnotify-dev libsqlite3-dev -y
########################################################################



############################## Bluetooth ###############################
# PRemoteDroid-Server needs libbluetooth
sudo apt-get install -y --force-yes libbluetooth-dev -y

sudo apt-get install -y --force-yes blueman
sudo apt-get install -y --force-yes bluez-hcidump

# hcidump -w hcidump.cap
# wireshark hcidump.cap
sudo apt-get install -y --force-yes wireshark -y

# bluez-5.3
sudo apt-get install -y --force-yes libudev-dev -y
sudo apt-get install -y --force-yes libical-dev
sudo apt-get install -y --force-yes libreadline-dev -y
########################################################################



############################## winmail.dat #############################
# fix thunderbird winmail.dat issue
sudo apt-get install -y --force-yes tnef

# extract attachment
# tnef winmail.dat

sudo apt-get install -y --force-yes convmv

# convert filename encoding
# convmv -f gbk -t utf8 --notest *.docx

convmv -r -f utf8 -t iso88591 *.mp3 --notest --nosmart && convmv -r -f gbk -t utf8 *.mp3 --notest --nosmart
########################################################################



############################## sun jdk #################################
sudo ./jdk-6u32-linux-i586.bin
sudo mv jdk1.6.0_32/ /usr/lib/jvm/
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.6.0_32/bin/java 87
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.6.0_32/bin/javac 87
# sudo update-alternatives --config java
########################################################################



############################## usb #####################################
# libusb
sudo apt-get install -y --force-yes libusb-dev
sudo apt-get install -y --force-yes libusb-1.0-0-dev
sudo apt-get install -y --force-yes libtool -y
########################################################################



############################## misc ####################################
sudo apt-get install -y --force-yes uboot-mkimage -y
sudo apt-get install -y --force-yes mtd-utils -y
sudo apt-get install -y --force-yes gawk -y
sudo apt-get install -y --force-yes procmail -y
sudo apt-get install -y --force-yes lzop -y

sudo apt-get install -y --force-yes uuid-dev

# usbboot
sudo apt-get install -y --force-yes libconfuse0 libconfuse-dev -y

# openocd
sudo apt-get install -y --force-yes openocd -y

# file /bin/sh
# sudo ln -fs /bin/bash /bin/sh

# libgmp.so.3 Cannot open shared object file
sudo apt-get install -y --force-yes libgmp3c2

# get repo
sudo apt-get install -y --force-yes curl

sudo apt-get install -y --force-yes gcc-arm-linux-gnueabi -y


# beyound compare
sudo gdebi /opt/software/ubuntu/bcompare/bcompare-3.3.5.15075_i386.deb

# internet

# nfs server
sudo apt-get install -y --force-yes nfs-kernel-server -y --force-yes

# Chromium, fast and best browser
# sudo apt-get install -y --force-yes chromium-browser -y

# file transfer(support SSH)
sudo apt-get install -y --force-yes filezilla -y

sudo apt-get install -y --force-yes adobe-flashplugin

sudo apt-get install -y --force-yes skype -y

# Teredo IPv6 tunneling software for Ubuntu
sudo apt-get install -y --force-yes miredo

sudo apt-get install -y --force-yes intltool -y

# Schedule alarms/reminders easily from an indicator
# sudo apt-get install -y --force-yes indicator-remindor


# apt-cache search linux-headers-$(uname -r)
# sudo apt-get install -y --force-yes linux-headers-$(uname -r)


# weather indicator
# sudo apt-get install -y --force-yes indicator-weather -y

# my-weather-indicator
# sudo add-apt-repository ppa:atareao/atareao
# sudo apt-get update
# sudo apt-get install -y --force-yes my-weather-indicator
########################################################################



############################## wordpress ###############################
sudo apt-get install -y --force-yes wordpress -y
sudo apt-get install -y --force-yes mysql-server -y
sudo ln -s /usr/share/wordpress /var/www/wordpress
sudo chown -R www-data /usr/share/wordpress
sudo bash /usr/share/doc/wordpress/examples/setup-mysql -n wordpress localhost
sudo service apache2 restart
########################################################################
