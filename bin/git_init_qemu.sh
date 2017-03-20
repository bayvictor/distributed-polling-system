echo "Ken WernerFeb 13, 2012 (edited)  -  Public
Howto | Setup an ARM Linux system for QEMU

I've been playing with QEMU lately and found that it's really awesome. To get started all you need is to create a root filesystem and cross compile a Kernel which is quite easy to set up on a Debian/Ubuntu based system. Here is what I did:


0 prerequisites
"

sudo apt-get install debootstrap qemu-user-static qemu-system git gcc-arm-linux-gnueabihf


echo "1 create the rootfs
# create the hard disk file
"

fallocate -l 2GiB ubuntu-armhf.ext3
mkfs.ext3 ubuntu-armhf.ext3

echo "# mount the hard disk file
"

mkdir mnt
sudo mount -o loop ubuntu-armhf.ext3 mnt

echo "# create an initial rootfs using debootstrap

debootstrap HOSTNAME=ubuntu-armhf sudo debootstrap --variant=minbase --foreign --arch armhf precise ./mnt
"


echo "^C to break, anykey to continue....";read readline

debootstrap HOSTNAME=ubuntu-armhf sudo debootstrap --variant=minbase --foreign --arch armhf precise ./mnt

# copy the statically linked QEMU binary into the rootfs
sudo cp /usr/bin/qemu-arm-static mnt/usr/bin/

# chroot into the rootfs and start a shell using "

qemu-arm-static  LANG=C 


sudo chroot mnt /usr/bin/qemu-arm-static -cpu cortex-a9 /bin/sh
# run the debootstrap second stage from within the chroot:
/debootstrap/debootstrap --second-stage

# create the sources.list files for apt:
echo "deb http://ports.ubuntu.com precise main restricted universe
deb-src http://ports.ubuntu.com precise main restricted universe" > /etc/apt/sources.list
echo "deb http://ddebs.ubuntu.com precise main restricted universe multiverse" > /etc/apt/sources.list.d/ddebs.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 428D7C01

# install some fundamental packages
apt-get update
apt-get install sudo apt-utils dialog less wget

# create configuration for the serial console
cp /etc/init/tty1.conf /etc/init/ttyAMA0.conf
sed -i "s/tty1/ttyAMA0/" /etc/init/ttyAMA0.conf

# add a user
adduser myuser
# add user to the sudo group
usermod -aG sudo myuser

# exit the chroot env
exit

# unmount the rootfs
sudo umount mnt
rmdir mnt

echo "^C to break, anykey to continue....";read readline

echo "2 cross compile the Kernel
# check out the sources
"


git clone -depth=1 git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
mkdir linux-build
cd linux
# create a .config based on the versatile express default configuration
make ARCH=arm O=../linux-build vexpress_defconfig
# compile the kernel
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=../linux-build -j`getconf _NPROCESSORS_ONLN` zImage
cd ..


echo "^C to break, anykey to continue....";read readline
echo "3 boot the image using QEMU
"

qemu-system-arm \
-M vexpress-a9 -m 1024 \
-serial stdio -no-reboot \
-kernel linux-build/arch/arm/boot/zImage \
-drive file=ubuntu-armhf.ext3,if=sd,cache=writeback \
--append "rw console=ttyAMA0,38400n8 console=tty root=/dev/mmcblk0"
