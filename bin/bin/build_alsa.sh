#apt-get source libasound2
cd alsa-lib*/
./configure --prefix=/usr --disable-python;
make -j 6 ; make install
