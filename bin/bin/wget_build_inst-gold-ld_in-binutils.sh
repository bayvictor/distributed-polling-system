mkdir gold
cd gold

wget http://ftp.de.debian.org/debian/pool/main/b/binutils/binutils_2.21.orig.tar.gz
tar -zxvf binutils_2.21.orig.tar.gz
cd binutils*
./configure  --enable-gold  --host= arm-linux-gnueabi --prefix=/opt/media/local
make -i
cd ..
ln   -s  binutils-2.21/gold/ld-new ld
 

