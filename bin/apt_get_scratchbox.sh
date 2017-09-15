# Edit (as root) /etc/apt/sources.list, and add this line: deb http://scratchbox.org/debian stable main
# Use the Synaptics Package Manager (in the System menu) to look at the available packages. You’ll need:
sudo apt-get install -y scratchbox-core scratchbox-libs qemu scratchbox-devkit-cputransp scratchbox-toolchain-arm-linux-2006q3-27

ln -s /sda1/home/vhuang/scratchbox/devkits/cputransp/bin/qemu-i386-0.8.2-sb2 /home/vhuang/bin/sb2

