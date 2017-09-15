cd /sda1/home/vhuang/src/qt5/2nd/qt-everywhere-opensource-src-5.0.0/xcb-git  

git clone --recursive git://anongit.freedesktop.org/git/xcb/util-wm
sudo apt-get install -y xutils-dev #- X Window System utility programs for development
cd util-wm
./autogen.sh
./configure
make 
sudo make install
   

