echo "Scratchbox needs to be installed as root:, ^c to break, anykey to continue"
sudo mkdir /work
sudo mkdir /work/scratchbox
sudo ln -s /work/scratchbox /scratchbox

#Scratchbox needs to be installed as root:
# for core, libs, toolchain, 
cd /tmp/
#wget http://www.scratchbox.org/download/files/sbox-releases/1.0/tarball/scratchbox-core-1.0.1-i386.tar.gz
#wget http://www.scratchbox.org/download/files/sbox-releases/1.0/tarball/scratchbox-libs-1.0.1-i386.tar.gz
#wget http://www.scratchbox.org/download/files/sbox-releases/1.0/tarball/scratchbox-toolchain-arm-gcc3.3-glibc2.3-1.0.1-i386.tar.gz
#tar -xzf scratchbox-core-1.0.1-i386.tar.gz -C /
#tar -xzf scratchbox-libs-1.0.1-i386.tar.gz -C /
#tar -xzf scratchbox-toolchain-arm-gcc3.3-glibc2.3-1.0.1-i386.tar.gz -C /

wget http://www.scratchbox.org/download/files/sbox-releases/stable/tarball/scratchbox-core-1.0.17-i386.tar.gz
wget http://www.scratchbox.org/download/files/sbox-releases/stable/tarball/scratchbox-libs-1.0.17-i386.tar.gz
wget http://www.scratchbox.org/download/files/sbox-releases/stable/tarball/scratchbox-toolchain-cs2007q3-glibc2.5-arm7-1.0.14-2-i386.tar.gz
wget http://www.scratchbox.org/download/files/sbox-releases/stable/tarball/scratchbox-devkit-qemu-0.12.50-0sb3-i386.tar.gz
wget http://www.scratchbox.org/download/files/sbox-releases/stable/tarball/scratchbox-toolchain-arm-linux-cs2009q3-67-1.0.14-1-i386.tar.gz
wget http://www.scratchbox.org/download/files/sbox-releases/stable/tarball/scratchbox-toolchain-cs2009q1-eglibc2.8-armv7-1.0.15-9-i386.tar.gz
wget http://www.scratchbox.org/download/files/sbox-releases/stable/tarball/scratchbox-devkit-debian-squeeze-1.0.3-i386.tar.gz

wget http://www.scratchbox.org/download/files/sbox-releases/stable/tarball/scratchbox-devkit-cputransp-1.0.9-i386.tar.gz
tar -xzf scratchbox-devkit-cputransp-1.0.9-i386.tar.gz -C /

tar -xzf scratchbox-core-1.0.17-i386.tar.gz -C /
tar -xzf scratchbox-libs-1.0.17-i386.tar.gz -C /
tar -xzf scratchbox-toolchain-cs2007q3-glibc2.5-arm7-1.0.14-2-i386.tar.gz -C /
tar -xzf scratchbox-devkit-qemu-0.12.50-0sb3-i386.tar.gz -C /
tar -xzf scratchbox-toolchain-arm-linux-cs2009q3-67-1.0.14-1-i386.tar.gz -C /
tar -xzf  scratchbox-toolchain-cs2009q1-eglibc2.8-armv7-1.0.15-9-i386.tar.gz -C /
tar -xzf scratchbox-devkit-debian-squeeze-1.0.3-i386.tar.gz -C /

/scratchbox/run_me_first.sh

echo "'run_me_first.sh' asks you some questions, just use defaults. After this we need to add user for Scratchbox. User must be some user that you have in your system. Do NOT add root user! e.g.:"

/scratchbox/sbin/sbox_adduser vhuang

ln -s /sda1/home/vhuang/scratchbox/devkits/cputransp/bin/qemu-i386-0.8.2-sb2 /home/vhuang/bin/sb2

## do it after login scratchbox as below:
ln -s /scratchbox/devkits/cputransp/bin/qemu-arm-0.8.2-sb2 ~/bin/sb2
export PATH=~/bin:$PATH:

# or:
#ln -s /scratchbox/devkits/cputransp/bin/qemu-armeb-0.8.2-sb2 ~/bin/sb2




