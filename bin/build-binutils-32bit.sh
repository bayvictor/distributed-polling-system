cd /home/vhuang/src/cmake/mingw32-binutils-2.20/upstream
tar -zxvf *.gz
cd binutils-2.20
./configure
make
sudo make install
sudo apt-get install -y mingw

