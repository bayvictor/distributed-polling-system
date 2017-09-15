echo "usage: $0 <into_dir> <dest_dir>
"
echo "Cntrl-C to break, any key to configure-make...";read readline
cd $1
cd source
sb2 ./configure
#sb2 make -jN
sb2 make -j3
sb2 make  install -y  DESTDIR=$2/root_fs


