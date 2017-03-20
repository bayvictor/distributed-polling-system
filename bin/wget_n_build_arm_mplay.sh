#wget http://www.mplayerhq.hu/MPlayer/releases/mplayer-export-snapshot.tar.bz2
#tar -jxvf mplayer-export-snapshot.tar.bz2
cd mplayer-export-snapshot
cd mplayer-export-2011-01-10
./configure  --yasm='' --prefix=/opt/media/local

make
make install

