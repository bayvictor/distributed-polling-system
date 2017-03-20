# This script helps me install -y --force-yes all the needed deb packages in my daily life
# Current version is for Ubuntu 14.04 (Trusty Tahr)


############################ Basic Setup ###############################
sudo apt-get install -y --force-yes ckermit automake -y
sudo apt-get install -y --force-yes ctags
sudo apt-get install -y --force-yes rar unrar tree
sudo apt-get install -y --force-yes p7zip-full
sudo apt-get install -y --force-yes ascii
sudo apt-get install -y --force-yes dos2unix
sudo apt-get install -y --force-yes goldendict -y

# grant access to /dev/ttyS0 (and friends), needs reboot
sudo adduser `whoami` dialout

sudo apt-get install -y --force-yes leafpad
sudo apt-get install -y --force-yes nautilus-open-terminal
sudo apt-get install -y --force-yes vim-gnome -y

# lndir
sudo apt-get install -y --force-yes xutils-dev
sudo apt-get install -y --force-yes audacity -y

# lrzsz: free x/y/zmodem implementation
sudo apt-get install -y --force-yes lrzsz

# ime
sudo apt-get install -y --force-yes ibus ibus-pinyin ibus-table-wubi -y

sudo apt-get install -y --force-yes screen

# feiQ
sudo apt-get install -y --force-yes iptux

# for iPod
sudo apt-get install -y --force-yes gtkpod -y
########################################################################



############################# MediaWiki ################################
sudo apt-get install -y --force-yes tasksel -y
sudo tasksel install -y --force-yes lamp-server
sudo apt-get install -y --force-yes mediawiki -y
sudo apt-get install -y --force-yes imagemagick mediawiki-math php5-gd -y
sudo sed -i 's/#Alias /Alias /g' /etc/mediawiki/apache.conf
sudo a2enconf mediawiki
sudo /etc/init.d/apache2 restart

sudo cp downloads/LocalSettings.php /etc/mediawiki/LocalSettings.php
########################################################################



############################ version control ###########################
sudo apt-get install -y --force-yes git-core -y
sudo apt-get install -y --force-yes git-email -y
sudo apt-get install -y --force-yes subversion -y
########################################################################



########################### for lwqq ###################################
sudo apt-get install -y --force-yes cmake -y
sudo apt-get install -y --force-yes libpurple-dev -y
sudo apt-get install -y --force-yes libcurl4-openssl-dev -y
sudo apt-get install -y --force-yes libsqlite3-dev
sudo apt-get install -y --force-yes libmozjs-17.0-dev -y
sudo apt-get install -y --force-yes libev-dev -y
sudo apt-get install -y --force-yes libmozjs185-dev -y
sudo apt-get install -y --force-yes pidgin -y
########################################################################



######################### for usb dev ##################################
# libusb
sudo apt-get install -y --force-yes libusb-dev

sudo apt-get install -y --force-yes libusb-1.0-0-dev -y
sudo apt-get install -y --force-yes python-usb
########################################################################



######################### for buildroot ################################
sudo apt-get install -y --force-yes texinfo -y
########################################################################



############################ linux kernel dev ##########################
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
sudo sed -i 's/\/srv\/tftp/\/tftpboot/g' /etc/inetd.conf
sudo /etc/init.d/openbsd-inetd restart
sudo apt-get install -y --force-yes openssh-server -y
########################################################################



############################ ftp server ###############################
sudo apt-get install -y --force-yes vsftpd
sudo sed -i 's/anonymous_enable=NO/anonymous_enable=yes/g' /etc/vsftpd.conf
sudo service vsftpd restart
sudo apt-get install -y --force-yes filezilla -y
########################################################################



############################# video program ############################
sudo apt-get install -y --force-yes mplayer -y
sudo apt-get install -y --force-yes smplayer -y
sudo apt-get install -y --force-yes winff libavcodec-extra-54 -y
sudo apt-get install -y --force-yes freetuxtv -y

# for program "Videos"
sudo apt-get install -y --force-yes gstreamer1.0-plugins-bad-videoparsers -y
sudo apt-get install -y --force-yes gstreamer1.0-plugins-bad-faad
sudo apt-get install -y --force-yes libopencv-video2.4 -y
sudo apt-get install -y --force-yes libmpg123-0


# for program "Videos" need to install -y --force-yes the following packages to play
# windoss asf files
sudo apt-get install -y --force-yes gstreamer1.0-plugins-ugly
sudo apt-get install -y --force-yes gstreamer1.0-libav

# for avi file merge
# avimerge -i a.avi b.avi -o c.avi
sudo apt-get install -y --force-yes transcode -y

# extract video from iso and convert to avi file
sudo apt-get install -y --force-yes dvdrip -y
########################################################################



############################# android stuff ############################
sudo apt-get install -y --force-yes flex -y
sudo apt-get install -y --force-yes bison -y
sudo apt-get install -y --force-yes gperf


########################################################################



############################## Bluetooth ###############################
sudo apt-get install -y --force-yes blueman
sudo apt-get install -y --force-yes bluez-hcidump

# used for locking/unlocking ubuntu
sudo apt-get install -y --force-yes blueproximity -y

# hcidump -w hcidump.cap
# wireshark hcidump.cap
sudo apt-get install -y --force-yes wireshark -y
sudo apt-get install -y --force-yes tshark
sudo apt-get install -y --force-yes wireshark-dev -y

# bluez-5.3
sudo apt-get install -y --force-yes libudev-dev
sudo apt-get install -y --force-yes libical-dev
sudo apt-get install -y --force-yes libreadline-dev -y

# sbc
sudo apt-get install -y --force-yes libsndfile1-dev
sudo apt-get install -y --force-yes libsbc-dev

# for wireshar build
sudo apt-get install -y --force-yes libqt4-dev -y
sudo apt-get install -y --force-yes libpcap-dev -y

sudo apt-get install -y --force-yes libbluetooth-dev
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
./jdk-6u37-linux-x64.bin
sudo mv jdk1.6.0_37/ /usr/lib/jvm/
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.6.0_37/bin/java 87
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.6.0_37/bin/javac 87
# sudo update-alternatives --config java
########################################################################



############################ dhcp server ###############################
sudo apt-get install -y --force-yes dhcpd
sudo sed -i 's/interface\teth0/interface\teth1/g' /etc/udhcpd.conf
sudo sed -i 's/192.168.142/192.168.7/g' /etc/udhcpd.conf

# enable dhcp
sudo sed -i 's/DHCPD_ENABLED/\# DHCPD_ENABLED/g' /etc/default/udhcpd
sudo service udhcpd restart
########################################################################



############################# nfs server ###############################
sudo apt-get install -y --force-yes nfs-kernel-server -y
sudo sed -i '$a/opt/nfsroot/       192.168.1.*(rw,sync,no_subtree_check)' /etc/exports
sudo service nfs-kernel-server restart
########################################################################



############################## misc ####################################
sudo apt-get install -y --force-yes valgrind

sudo apt-get install -y --force-yes flashplugin-installer

# cisco vpn
sudo apt-get install -y --force-yes openconnect -y

#  e.g. errno 5
# EIO 5 Input/output error
sudo apt-get install -y --force-yes errno -y

# android tools
sudo apt-get install -y --force-yes android-tools-adb
sudo apt-get install -y --force-yes android-tools-fastboot
sudo apt-get install -y --force-yes phablet-tools -y
sudo apt-get install -y --force-yes eclipse -y

# mkimage
sudo apt-get install -y --force-yes u-boot-tools

# used for lookup LAN friends
# sudo arp-scan -I eth0 -l
sudo apt-get install -y --force-yes arp-scan

sudo apt-get install -y --force-yes iperf

# Synergy (mouse and keyboard sharing software) for Windows,
# Mac OS X and Linux
sudo apt-get install -y --force-yes synergy

# for building webqq-core
# mvn clean install
sudo apt-get install -y --force-yes maven -y

# sbc decode/encode
# sbcdec -f test.pcm test.sbc
sudo apt-get install -y --force-yes sbc-tools

sudo apt-get install -y --force-yes feedgnuplot -y

# for ubertooth-specan-ui
sudo apt-get install -y --force-yes python-pyside -y

# disable auto mount mtp
gsettings set org.gnome.desktop.media-handling automount-open false

sudo apt-get install -y --force-yes gphoto2 -y

gphoto2 --port=usb: -R -P
gphoto2 --port=usb: -R -P 100-107

########################################################################



############################## wordpress ###############################
sudo apt-get install -y --force-yes wordpress -y
sudo apt-get install -y --force-yes mysql-server -y

# example 1
sudo ln -s /usr/share/wordpress /var/www/wordpress
sudo chown -R www-data /usr/share/wordpress

# example 2
sudo ln -s /opt/fdbai/wordpress/linuxabc /var/www/linuxabc
sudo chown -R www-data /opt/fdbai/wordpress/linuxabc

sudo sed -i 's/Listen 80/Listen 8989/g' /etc/apache2/ports.conf

sudo service apache2 restart

sudo apt-get install -y --force-yes phpmyadmin -y
sudo ln -s /usr/share/phpmyadmin  /var/www/
########################################################################
