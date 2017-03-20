mkdir /sda1/home/vhuang/src/qt5
mkdir /sda1/home/vhuang/2nd
cd  /sda1/home/vhuang/2nd
#wget http://releases.qt-project.org/qt5.0/alpha/qt-everywhere-opensource-src-5.0.0-alpha.tar.gz
tar -zxvf qt-everywhere-opensource-src-5.0.0-alpha.tar.gz
export QTDIR=/sda1/home/vhuang/src/qt5/2nd/qt-everywhere-opensource-src-5.0.0
export PATH=${QTDIR}/qtbase/bin:$PATH
cd $QTDIR

sudo apt-get install -y opengles-sgx-img-common-dev  ## ins EGLFS
sudo apt-get install -y gperf #- Perfect hash function generator
sudo apt-get install -y libdirectfb-dev #- direct frame buffer graphics library #- devel
sudo apt-get install -y libegl1-mesa-dev #- free implementation of the EGL API -- development filesopment files
sudo apt-get install -y libegl1-mesa-drivers #- free implementation of the EGL API -- hardware drivers
sudo apt-get install -y libgegl-0.0-dev #- Generic Graphics Library (development files)
sudo apt-get install -y mesa-utils-extra #- Miscellaneous Mesa utilies (opengles, egl)


sudo apt-get update -y 
sudo apt-get install -y qt50-snapshot

sudo apt-get install -y libxcb1 libxcb1-dev libx11-xcb1 libx11-xcb-dev libxcb-keysyms1 libxcb-keysyms1-dev libxcb-image0 libxcb-image0-dev libxcb-shm0 libxcb-shm0-dev

apt-get source libxcb-icccm4-dev
cd xcb-util-wm-0.3.8
autoconf
automake
./configure
make
sudo make install

sudo apt-get install -y libxcb-icccm4-dev libxcb-icccm4-dev:i386
sudo apt-get install -y  libxcb-sync0 libxcb-sync0-dev libxcb-render-util0 libxcb-render-util0-dev libxcb-xfixes0-dev

echo "^c to break..."
read readline

#wget http://archive.ubuntu.com/ubuntu/pool/main/x/xcb-util/xcb-util_0.3.6.orig.tar.gz
tar -zxvf xcb-util_0.3.6.orig.tar.gz
cd xcb-util-0.3.6
./autogen.sh
./configure
make
sudo make install
echo "^c to break..."
read readline

sudo apt-get install -y autoconf #- automatic configure script builder
sudo apt-get install -y automake #- Tool for generating GNU Standards-compliant Makefiles

sudo apt-get install -y bison
sudo apt-get install -y flex 


sudo apt-get install -y ruby-gstreamer #- GStreamer bindings for the Ruby language

sudo apt-get install -y qtgstreamer-plugins #- GStreamer plugins from QtGStreamer
sudo apt-get install -y xcb #- Pigeon holes for your cut and paste selections
sudo apt-get install -y  gst-plugins-bad gst-plugins-ugly  gst-ffmpeg 
#wget http://gstreamer.freedesktop.org/src/gstreamer/gstreamer-0.11.90.tar.gz

cd $QTDIR
mkdir /sda1/home/vhuang/src/qt5/2nd/qt-everywhere-opensource-src-5.0.0/xcb-git   
cd /sda1/home/vhuang/src/qt5/2nd/qt-everywhere-opensource-src-5.0.0/xcb-git  

git clone --recursive git://anongit.freedesktop.org/git/xcb/util-wm
sudo apt-get install -y xutils-dev #- X Window System utility programs for development
cd util-wm
./autogen.sh
./configure
make 
sudo make install
   
cd $QTDIR


tar -zxvf gstreamer-0.11.90.tar.gz
cd gstreamer-0.11.90
./autogen.sh
./configure
make
sudo make install
cd ..

cd $QTDIR
  ./configure -developer-build -opensource
   make -j4
sudo make install



