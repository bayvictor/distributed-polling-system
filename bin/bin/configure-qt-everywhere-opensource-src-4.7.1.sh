sudo apt-get install -y libgstreamer0.10-dev #- GStreamer core development files
sudo apt-get install -y libnice-dev #- ICE library (development files)
sudo apt-get install -y libqtgstreamer-dev #- Development headers for QtGStreamer
sudo apt-get install -y libclutter-gst-dev #- Open GL based interactive canvas library GStreamer elements (development files)
sudo apt-get install -y libgstreamer-plugins-base0.10-dev #- GStreamer development files for libraries from the "base" set


./configure   -qt-zlib   -qt-libtiff   -qt-libpng  -qt-libmng  -qt-libjpeg  -openssl-linked  -developer-build  -platform linux-g++-64


