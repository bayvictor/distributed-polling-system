#!/bin/bash -x 

#Installing_scratchbox_1_and_2_for_ARM_cross-compilation.sh
#This is Google's cache of http://felipec.wordpress.com/2009/06/07/installing-scratchbox-1-and-2-for-arm-cross-compilation/

echo "Installing scratchbox 1 and 2 for ARM cross-compilation

June 7, 2009 by FelipeC 19 Comments"
read readline



echo "Installing scratchbox 1

Many people think it’s difficult to install, but it’s not. Just follow these easy steps:
install"
read readline
echo "Download the basic packages....:"

mkdir /hathor-sbox
cd /hathor-sbox/
wget -c http://scratchbox.org/download/files/sbox-releases/hathor/tarball/scratchbox-core-1.0.24-i386.tar.gz
wget  -c http://scratchbox.org/download/files/sbox-releases/hathor/tarball/scratchbox-libs-1.0.24-i386.tar.gz
wget -c http://scratchbox.org/download/files/sbox-releases/hathor/tarball/scratchbox-devkit-qemu-0.12.50-0sb3-i386.tar.gz
wget -c http://scratchbox.org/download/files/sbox-releases/hathor/tarball/scratchbox-toolchain-cs2009q3-eglibc2.10-armv7-hard-1.0.22-14-i386.tar.gz
wget -c http://scratchbox.org/download/files/sbox-releases/hathor/tarball/scratchbox-toolchain-cs2009q3-eglibc2.10-armv7-soft-1.0.19-6-i386.tar.gz
wget -c http://scratchbox.org/download/files/sbox-releases/hathor/tarball/scratchbox-toolchain-cs2009q3-eglibc2.10-i486-1.0.22-9-i386.tar.gz
wget -c http://scratchbox.org/download/files/sbox-releases/hathor/tarball/scratchbox-toolchain-host-gcc-1.0.24-i386.tar.gz


#wget -c http://scratchbox.org/download/files/sbox-releases/apophis/tarball/scratchbox-core-1.0.14-i386.tar.gz
#wget -c http://scratchbox.org/download/files/sbox-releases/apophis/tarball/scratchbox-libs-1.0.14-i386.tar.gz
#wget -c http://scratchbox.org/download/files/sbox-releases/apophis/tarball/scratchbox-devkit-qemu-0.10.0-0sb5-i386.tar.gz
#wget -c http://scratchbox.org/download/files/sbox-releases/apophis/tarball/scratchbox-toolchain-cs2007q3-glibc2.5-arm7-1.0.12-9-i386.tar.gz
echo "^c to break! unzip under root!"
read readline

echo "Extract them:"
sudo tar -xf /tmp/sb/scratchbox-core-*-i386.tar.gz -C /opt
sudo tar -xf /tmp/sb/scratchbox-libs-*-i386.tar.gz -C /opt
sudo tar -xf /tmp/sb/scratchbox-devkit-qemu-*386.tar.gz -C /opt
sudo tar -xf /tmp/sb/scratchbox-toolchain-*-i386.tar.gz -C /opt

echo "^c to break! unzip under root!"
read readline
Setup scratchbox, and add your user:
sudo /opt/scratchbox/run_me_first.sh
sudo /opt/scratchbox/sbin/sbox_adduser $USER yes

echo "^c to break! unzip under root!"
read readline

echo "You will need to re-login to be in the sbox group and have proper permissions:"
sudo su $USER
target

echo "Finally, setup an armv7 target (you can have multiple targets inside scratchbox):"
echo "^c to break! unzip under root!"
read readline

/opt/scratchbox/tools/bin/sb-conf setup armv7 --force --compiler="cs2007q3-glibc2.5-arm7" --devkits="qemu" --cputransp="qemu-arm-sb"
/opt/scratchbox/tools/bin/sb-conf select armv7
/opt/scratchbox/tools/bin/sb-conf install armv7 --clibrary --devkits --fakeroot --etc

echo "^c to break! unzip under root!"
read readline


echo "That is it, you have scratchbox setup :) I explicitly mentioned all the commands, but instead you can run this script that I wrote.
start

Before running scratchbox you will need to do some steps as root:
"
echo 0 > /proc/sys/vm/vdso_enabled
echo 4096 > /proc/sys/vm/mmap_min_addr
/opt/scratchbox/sbin/sbox_ctl start

echo "^c to break! unzip under root!"
read readline

echo "And then as user:"
/opt/scratchbox/login


echo "Now if you want to cross-compile GLib, you do it as in your PC:
./configure && make install

Much easier, now scratchbox does all the magic ;)"
echo "^c to break! unzip under root!"
read readline

echo "Scratchbox 2

Scratchbox 1 serves its purpose, but there are many corner-cases where things get overly complicated so people came up with a much more elegant approach: Scratchbox 2.

In sb1 you need to login to a target (e.g. armv7, armv6, fremantle, diablo, etc.) in order to do anything, you can use only one target at a time, and each target is independent, in order to share tools between targets you need a devkit. Also, toolchains must be packaged in a special way.

In sb2, you dont login, you can setup any toolchain easily, you can use multiple targets at the same time, and you can configure it to do pretty much anything you want.
QEMU

sb2 doesnot include QEMU, you must have it already, this is how I compile it:"

git clone git://git.savannah.nongnu.org/qemu.git
cd qemu
git checkout -b stable v0.10.5
./configure --prefix=/opt/qemu --target-list=arm-linux-user
make install
sbox2

echo "Compile and install like this:"
git clone git://anongit.freedesktop.org/git/sbox2
cd sbox2
./configure --prefix=/opt/sb2
make install

echo "Add sb2 to the PATH:"
export PATH=/opt/sb2/bin:$PATH
target

echo "Now it is time to configure a target, I have a CodeSourcery toolchain installed on /opt/arm-2008q3, so: "

cd /opt/arm-2008q3/arm-none-linux-gnueabi/libc/
sb2-init -c /opt/qemu/bin/qemu-arm armv7 /opt/arm-2008q3/bin/arm-none-linux-gnueabi-gcc

echo "You dont need to log-in, just prefix your commands with sb2 to do the magic:"
sb2 ./configure --prefix=/opt/arm/

echo "If you want to use a different target just use the -t option: "
sb2 -t armv8 ./configure --prefix=/opt/arm/

echo "How cool is that? "

