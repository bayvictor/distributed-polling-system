

sudo apt-get install -y binutils-arm-linux-gnueabi #- GNU binary utilities, for arm-linux-gnueabi target
sudo apt-get install -y g++-arm-linux-gnueabi #- The GNU C++ compiler for armel architecture
sudo apt-get install -y g++-arm-linux-gnueabihf #- The GNU C++ compiler for armhf architecture

 
sudo apt-get install -y scratchbox2 #- Transparent cross compiling environment
echo "
do below to initiate:

    sb2-init -c qemu-arm ARM arm-linux-gcc
    sb2-init -c qemu-arm -m devel ARM arm-linux-gcc
    sb2-init -sn -c sbrsh armel-debian /path/to/arm-linux-gcc:/path/to/gcc-specs

"

cd /usr/bin
sudo ln -s  arm-linux-gnueabi-cpp	 arm-linux-cpp
sudo ln -s  arm-linux-gnueabi-g++	 arm-linux-g++
sudo ln -s  arm-linux-gnueabi-gcc	 arm-linux-gcc
sudo ln -s  arm-linux-gnueabi-gcov	 arm-linux-gcov


cd /home/vhuang/src/qt-everywhere-opensource-src-4.8.4-arm


./configure -prefix /opt/qtLib -release -opensource -shared -embedded arm -xplatform qws/linux-arm-g++ -no-fast -no-largefile -qt-sql-sqlite -no-qt3support -multimedia -audio-backend -phonon -phonon-backend -no-svg -webkit -qt-libtiff -qt-libpng -qt-libmng -qt-libjpeg -nomake examples -nomake demos -nomake docs -make tools -v -silent -no-cups -no-separate-debug-info -glib -I /usr/include/glib-2.0 -L /usr/lib/glib-2.0 -qt-mouse-tslib -I /opt/tsLib/include -L /opt/tsLib/lib -I /usr/include -L /usr/lib -force-pkg-config


