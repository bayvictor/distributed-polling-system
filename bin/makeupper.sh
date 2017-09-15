export PATH=$PWD/../bin:$PATH
export LD_LIBRARY_PATH=$PWD/../lib:$LD_LIBRARY_PATH

aclocal
autoconf
automake
./configure --prefix=${PWD}/..
make
make install



