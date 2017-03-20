
apt-get update -y && apt-get -y upgrade
apt-get install -y qemu-kvm
ln -s /usr/bin/qemu-system-x86_64 /usr/local/bin/qemu
ln -s /usr/bin/qemu-img /usr/local/bin/qemu-img
qemu-img
echo "^C to break,anykey to continue..."; read readline
 

apt-get install -y qemu-kvm 
echo "Booting a QEMU based BeagleBoard
Linaro has contributed a significant amount of effort to improving and maintaining the beagleboard port in QEMU. Here are the instructions for creating a bootable image and then using this image to boot to a shell prompt on your host.
Download and install required packages
You can download a pre-built image
Or build your own with some customizations:
Download linaro-media-create
$ "
apt-get install -y linaro-image-tools 
echo "Download a rootfs and a hwpack
Six-monthly Linaro releases can be found at:
http://releases.linaro.org/
The daily releases (which may or may not work) can be found at:
http://snapshots.linaro.org/
Install QEMU
$ "
apt-get install -y qemu-user-static qemu-system
echo "Building a runnable image
Use linaro-media-create to build an image you can use to boot
The resulting image will be owned by root; make it owned by you so you can run QEMU as your normal user:
"
sudo chown $USER:$USER beagle.img
echo "install Rn the image in QEMU
$ "
qemu-system-arm -M beaglexm -drive if=sd,cache=writeback,file=./beagle.img -clock unix -serial stdio -device usb-kbd -device usb-mouse -usb -device usb-net,netdev=mynet -netdev user,id=mynet

echo "
USB keyboard and mouse are supported starting with qemu-linaro 2011.06, for Linaro images of the 11.05 release or later. USB networking is supported starting with qemu-linaro 2011.10.
Note the use of "cache=writeback" here: this significantly improves I/O performance over the default (cache=writethrough, or if using the old-style "-sd file.img" option). However you should be aware that if the host crashes then the guest's filesystem on the disk image may be corrupted. (Guest crashes are not problematic.) For most uses of ARM guests this is acceptable.
Updating image contents
For QEMU versions after qemu-linaro 2011.10 this section can be ignored -- just use the networking to transfer files into the guest.
For QEMU versions before qemu-linaro 2011.10, networking is unsupported, and so any files you need to transfer have to be copied to the mounted image, like this:
We need to mount the partition in the QEMU image on the host using a loopback mount. First find the ext3 partition inside the image file by:
$ fdisk -ul beagle_sd.img
        Device Boot      Start         End      Blocks   Id  System
beagle_sd.img1   *          63      106494       53216    c  W95 FAT32 (LBA)
beagle_sd.img2          106496     4194303     2043904   83  Linux
take the "start" number of beagle_sd.img2 (106496) and feed it to the mount command multiplied by block size (512):
$ "
sudo mount -o loop,offset=$[106496*512] beagle_sd.img /mnt/
cp linux-image*_armel.deb /mnt/root/


