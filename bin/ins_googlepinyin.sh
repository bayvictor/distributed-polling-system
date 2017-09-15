cd /sda8/home/vhuang/src/ime
    
/home/vhuang/bin/setup_automake_autoconf.sh
/home/vhuang/bin/install-chrome.sh
 cd scim-1.4.9/
./bootstrap
./configure
cmake
sudo make install
d ../googleim*
./autogen
./configure
make
sudo make install





