sudo apt-get install -y libgtk2.0-dev libwxgtk2.8-dev

cd /home/vhuang/src/SLP/image_recognition/unzip/tina-libs-6.0rcbuild004/
./configure
make
sudo make install
cd /home/vhuang/src/SLP/image_recognition/unzip/tina-tools-6.0rcbuild004
./configure
make


