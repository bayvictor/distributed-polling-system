
sudo apt-get install -y libudev-dev #- udev library (development files)

./configure -developer-build -opensource -nomake examples -nomake tests  -qt-zlib    -qt-libpng    -qt-libjpeg  -shared -opengl   -debug-and-release 


build -j 3

