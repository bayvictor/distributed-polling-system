echo "This version is buggy & not working....~! ^C to break!"

# 
# 2010-12-22-10-49-03
#wget http://downloads.sourceforge.net/mediatomb/mediatomb-0.10.0.tar.gz
# wget http://sourceforge.net/projects/mediatomb/files/MediaTomb/0.12.1/mediatomb-0.12.1.tar.gz/download
sudo apt-get install -y sqlite3

cd ~/src/glen/dlna/

#wget http://ftp.mozilla.org/pub/mozilla.org/js/js-1.7.0.tar.gz
wget http://ftp.mozilla.org/pub/mozilla.org/js/js-1.8.0-rc1.tar.gz
#tar xzf ../dl/js-1.7.0.tar.gz
tar -zxvf js-1.8.0-rc1.tar.gz
cd ~/src/glen/dlna/js/src
cd js/src

make -f Makefile.ref BUILD_OPT=1
#as root:
sudo cp -p Linux_All_OPT.OBJ/libjs.so \
  /usr/lib/libjs.so.1.8.0-rc1
sudo cp -p Linux_All_OPT.OBJ/libjs.a /usr/lib




cd /home/vhuang/src/glen/
gzip -cd mediatomb-0.12.1.tar.gz | tar -xf -
cd mediatomb-0.12.1

./configure --includedir=/usr/local/include:~/src/glen/dlna/js/src \
        --libdir=/usr/local/lib:~/src/glen/dlna/js/src/Linux_All_OPT.OBJ \
        --prefix=/opt/mediatomb \
				--enable-sqlite3 --enable-libjs \
				--enable-id3lib --enable-libexif \
				--enable-mrreg-service --enable-protocolinfo-extension

make
make install
strip /opt/mediatomb/bin/mediatomb

