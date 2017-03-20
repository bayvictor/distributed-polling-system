
mkdir ~/src/bzlib
cd ~/src/bzlib/
apt-get source libbz2
cd bzip2-1.0.5
CURDIR=$PWD
make -f Makefile-libbz2_so
#make -f Makefile-libbz2_so install

ls *.h
cp libbz2.so.1.0.4 /opt/media/local/lib/
cd /opt/media/local/lib/
rm -f libbz2.so.1.0
ln -s libbz2.so.1.0.4 libbz2.so.1.0
ls /opt/media/local/include/
cp *.h /opt/media/local/include/
cp ~/src/bzlib/bzip2-1.0.5/*.h /opt/media/local/include/
cd $CURDIR

	
	