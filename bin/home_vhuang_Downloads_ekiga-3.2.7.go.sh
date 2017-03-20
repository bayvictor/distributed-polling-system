cd /home/vhuang/Downloads/ekiga-3.2.7

~/bin/ins_all_32bitlib.sh
sudo ln -s /usr/lib32/gcc/i686-linux-gnu /usr/lib/gcc/i686-linux-gnu
sudo ln -s /usr/lib32/gcc/i686-linux-gnu/4.5 /usr/lib/gcc/i686-linux-gnu/4.4.5

sudo apt-get install -y libsigc++-dev #
sudo apt-get install -y  libsigc++-2.0-dev

sudo apt-get install -y libdbus-glib-1-dev 
sudo apt-get install -y libdbus-1-dev
#libdbus-1-dev   

sudo apt-get install -y libxml2-dev
sudo apt-get install -y  libsasl2-dev    
sudo apt-get install -y libebook1.2-dev
sudo apt-get install -y intltool

sudo apt-get install -y    libopal-dev

sudo apt-get install -y    libpt-dev 

sudo apt-get install -y    libavahi-glib-dev 


sudo apt-get install -y     libxv-dev   
sudo apt-get install -y gconf2-common 

 sudo apt-get install -y libgconf2-dev
 sudo apt-get install -y gconf2

echo "press ^c to build ekiga!..."
read readline
./autogen.sh

autoconf
automake
./configure
make 
sudo make install

