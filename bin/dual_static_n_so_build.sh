

## building static lib -- default
make distclean
./configure --prefix=/opt/media/local 
make;make install

## build dynamic library
make distclean
/configure --prefix=/opt/media/local --enable-shared
make; make install
  
