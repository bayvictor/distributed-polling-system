sudo apt-get  install -y  -y libgusb2 #- GLib wrapper around libusb1
sudo apt-get  install -y  -y libsb2 #- Scratchbox2 libraries
sudo apt-get  install -y  scratchbox2 -y 
echo "Install in local machine:
"
sudo apt-get  install -y  scratchbox2 fakeroot
sudo apt-get  install -y  qemu-user qemu
sudo apt-get  install -y  gcc-arm-linux-gnueabi
#sudo apt-get  install -y  cpp-4.4-arm-linux-gnueabi gcc-4.4-arm-linux-gnueabi gcc-4.4-arm-linux-gnueabi-base
#sudo apt-get  install -y  cpp-4.5-arm-linux-gnueabi g++-4.5-arm-linux-gnueabi gcc-4.5-arm-linux-gnueabi
## get by aptseek.sh arm-linux-gnueabit

sudo apt-get install -y binutils-arm-linux-gnueabi #- GNU binary utilities, for arm-linux-gnueabi target
sudo apt-get install -y binutils-arm-linux-gnueabihf #- GNU binary utilities, for arm-linux-gnueabihf target
sudo apt-get install -y cpp-4.7-arm-linux-gnueabi #- GNU C preprocessor
sudo apt-get install -y cpp-4.7-arm-linux-gnueabihf #- GNU C preprocessor
sudo apt-get install -y cpp-arm-linux-gnueabi #- The GNU C preprocessor (cpp) for armel architecture
sudo apt-get install -y cpp-arm-linux-gnueabihf #- The GNU C preprocessor (cpp) for armhf architecture
sudo apt-get install -y g++-4.7-arm-linux-gnueabi #- GNU C++ compiler
sudo apt-get install -y g++-4.7-arm-linux-gnueabihf #- GNU C++ compiler
sudo apt-get install -y g++-4.7-multilib-arm-linux-gnueabi #- GNU C++ compiler (multilib files)
sudo apt-get install -y g++-4.7-multilib-arm-linux-gnueabihf #- GNU C++ compiler (multilib files)
sudo apt-get install -y g++-arm-linux-gnueabi #- The GNU C++ compiler for armel architecture
sudo apt-get install -y g++-arm-linux-gnueabihf #- The GNU C++ compiler for armhf architecture
sudo apt-get install -y gcc-4.7-arm-linux-gnueabi #- GNU C compiler
sudo apt-get install -y gcc-4.7-arm-linux-gnueabi-base #- GCC, the GNU Compiler Collection (base package)
sudo apt-get install -y gcc-4.7-arm-linux-gnueabihf #- GNU C compiler
sudo apt-get install -y gcc-4.7-arm-linux-gnueabihf-base #- GCC, the GNU Compiler Collection (base package)
sudo apt-get install -y gcc-4.7-multilib-arm-linux-gnueabi #- GNU C compiler (multilib files)
sudo apt-get install -y gcc-4.7-multilib-arm-linux-gnueabihf #- GNU C compiler (multilib files)
sudo apt-get install -y gcc-arm-linux-gnueabi #- The GNU C compiler for armel architecture
sudo apt-get install -y gcc-arm-linux-gnueabihf #- The GNU C compiler for armhf architecture
sudo apt-get install -y gccgo-4.7-arm-linux-gnueabi #- GNU Go compiler
sudo apt-get install -y gccgo-4.7-arm-linux-gnueabihf #- GNU Go compiler
sudo apt-get install -y gccgo-arm-linux-gnueabihf #- Go compiler, based on the GCC backend
sudo apt-get install -y gobjc++-4.7-arm-linux-gnueabi #- GNU Objective-C++ compiler
sudo apt-get install -y gobjc++-4.7-arm-linux-gnueabihf #- GNU Objective-C++ compiler
sudo apt-get install -y gobjc++-4.7-multilib-arm-linux-gnueabi #- GNU Objective-C++ compiler (multilib files)
sudo apt-get install -y gobjc++-4.7-multilib-arm-linux-gnueabihf #- GNU Objective-C++ compiler (multilib files)
sudo apt-get install -y gobjc++-arm-linux-gnueabi #- The GNU Objective-C++ compiler for armel architecture
sudo apt-get install -y gobjc++-arm-linux-gnueabihf #- The GNU Objective-C++ compiler for armhf architecture
sudo apt-get install -y gobjc-4.7-arm-linux-gnueabi #- GNU Objective-C compiler
sudo apt-get install -y gobjc-4.7-arm-linux-gnueabihf #- GNU Objective-C compiler
sudo apt-get install -y gobjc-4.7-multilib-arm-linux-gnueabi #- GNU Objective-C compiler (multilib files)
sudo apt-get install -y gobjc-4.7-multilib-arm-linux-gnueabihf #- GNU Objective-C compiler (multilib files)
sudo apt-get install -y gobjc-arm-linux-gnueabi #- The GNU Objective-C compiler for armel architecture
sudo apt-get install -y gobjc-arm-linux-gnueabihf #- The GNU Objective-C compiler for armhf architecture
sudo apt-get install -y pkg-config-arm-linux-gnueabi #- manage compile and link flags for libraries for armel architecture
sudo apt-get install -y pkg-config-arm-linux-gnueabihf #- manage compile and link flags for libraries for armhf architecture



echo "Init scratchbox configuration:
"
fakeroot debootstrap --variant=scratchbox --foreign --arch armel squeeze ~/apps/arm-root_fs http://ftp.br.debian.org/debian
sb2-init -n -c /usr/bin/qemu-arm MACHINE_NAME "arm-linux-gnueabi-gcc"

echo "Install into emulated system:
"
apt-get  install -y  g++ rpm zlib1g-dev m4 bison libncurses5-dev gettext build-essential intltool libxml2-dev libtool

echo "Compile outside the box:
"


cd source
sb2 ./configure
#sb2 make -jN
sb2 make -j3
sb2 make  install -y  DESTDIR=/path/root_fs

echo "To change the crosscompiler toolchain  install -y  the script /usr/local/bin/switch_arm-linux-gnueabi.sh:
"
echo "STOP! check, copy-paste below script first! ^C to break, anykey to dummpy link";read readline

cat  ~/bin/switch_arm-linux-gnueabi.sh
echo " ^C to break, anykey to quit";read readline

