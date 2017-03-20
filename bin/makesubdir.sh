cd $1 

export PATH=$PWD/../bin:$PATH
export LD_LIBRARY_PATH=$PWD/../lib:$LD_LIBRARY_PATH


./autostrap
aclocal
autoconf
automake


# install normally to /usr/lib etc
#./configure --prefix=/usr
#make
#sudo make install



./configure --prefix=${HOME}/opt 
make
make install
cd ..


