sudo apt-get install -y  libxext-dev 




cd /home/vhuang/src
#wget ftp://ftp.trolltech.com/qt/source/qt-x11-free-3.3.6.tar.bz2
#tar -jxvf qt-x11-free-3.3.6.tar.bz2
#cd qt-x11-free-3.3.6

#wget ftp://ftp.trolltech.com/qt/source/qt-x11-free-3.3.8b.tar.gz
#tar -zxvf qt-x11-free-3.3.8b.tar.gz
cd qt-x11-free-3.3.8b


./configure   -qt-zlib     -qt-libpng  -qt-libmng  -qt-libjpeg  # -openssl-linked  #-developer-build  -platform linux-g++ --prefix=/usr -webkit -no-javascript-jit 

echo "add \"#include <stddef.h>\" into <qglobal.h> to avoid  (\"error: ‘ptrdiff_t’ does not name a type!\") ERROR!"
echo "before \"make -j 6\" it!"
read readline


#/opt/media/local
make
#make -j 6 ; make install


pwd


