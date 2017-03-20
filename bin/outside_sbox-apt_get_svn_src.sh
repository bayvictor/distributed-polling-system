echo "do it outside sbox...!^C to break!"

cd $VSRC

cp /usr/include/X11/extensions/scrnsaver.h /scratchbox/users/$USER/targets/aquila-device/usr/include/X11/extensions/
cp /usr/include/X11/extensions/scrnsaver.h /scratchbox/users/$USER/targets/aquila-simulator/usr/include/X11/extensions/
cp /usr/include/X11/extensions/scrnsaver.h /scratchbox/users/$USER/targets/victor00/usr/include/X11/extensions/
apt-get source git-core

echo "^c to break, anykey to continue...apt-get source subversion"
read readline

apt-get source git-core 
apt-get source libvpx-dev
apt-get source subversion

cd subversion-1.6.12dfsg 

wget http://mirrors.kahuki.com/apache/apr/apr-util-1.3.10.tar.bz2
wget http://mirrors.kahuki.com/apache/apr/apr-1.4.2.tar.bz2
tar -jxvf apr-1.4.2.tar.bz2
tar -jxvf apr-util-1.3.10.tar.bz2
ln -s apr-util-1.3.10 apr-util 
ln -s apr-1.4.2 apr
echo "^c to break! do below inside sbox!"
read read_line

./autogen.sh
./configure
make;make install


