echo "Using scratchbox2 and Ubuntu 11.10


Local machine environment:
- Ubuntu 11.10 64bits

Emulated environment:
- Debian Squeeze armel

Install in local machine:
"

sudo apt-get install scratchbox2 fakeroot
sudo apt-get install qemu-user qemu
sudo apt-get install gcc-arm-linux-gnueabi
sudo apt-get install cpp-4.4-arm-linux-gnueabi gcc-4.4-arm-linux-gnueabi gcc-4.4-arm-linux-gnueabi-base
sudo apt-get install cpp-4.5-arm-linux-gnueabi g++-4.5-arm-linux-gnueabi gcc-4.5-arm-linux-gnueabi

echo "Init scratchbox configuration:
"

fakeroot debootstrap --variant=scratchbox --foreign --arch armel squeeze /path/root_fs http://ftp.br.debian.org/debian
sb2-init -n -c /usr/bin/qemu-arm MACHINE_NAME "arm-linux-gnueabi-gcc"

echo "Install into emulated system:
"

apt-get install g++ rpm zlib1g-dev m4 bison libncurses5-dev gettext build-essential intltool libxml2-dev libtool

echo "Compile outside the box:
"

cd source
sb2 ./configure
sb2 make -jN
sb2 make install DESTDIR=/path/root_fs



