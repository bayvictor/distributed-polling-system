cd /home/vhuang/src/gold/binutils-2.21
armconf

cp /home/vhuang/src/gold/binutils-2.21/gold/ld-new /opt/medial/local/bin/ld

cd ~/src
cd git-1.7.1 
armconf


echo "^c to break, anykey to build svn..."
read readline
cd subversion-1.6.12dfsg
make distclean
./go.sh
cd ..

cd ~/src/gold/binutils-2.21/
make install
	  
cd ~/src/bzlib/bzip2-1.0.5
armconf

