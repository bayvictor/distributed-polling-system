#wget http://ftp.de.debian.org/debian/pool/main/l/lzo2/lzo2_2.03.orig.tar.gz
#tar -zxvf lzo2_2.03.orig.tar.gz
cd lzo-2.03   
./configure --prefix=/opt/media/local  --enable-shared

make
make install
# above line: no sudo required in scratchbox!
