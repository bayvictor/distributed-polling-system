apt-get source binutils
cd binutils-2.18.1~cvs20080103
./configure  --enable-gold  --host= arm-linux-gnueabi
make -i
cd ..
ln -s binutils-2.18.1~cvs20080103/gold/ld-new ld

