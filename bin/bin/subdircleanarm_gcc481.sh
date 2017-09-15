
unset curdir
unset ARMROOT
unset LL
unset CFLAGS
unset CXXFLAGS
unset LDFLAGS

export vdir=${HOME}/victor
export gccdir=${vdir}/arm-linux-gnueabi-gcc-4.8.1

#arm-eabi-c++  arm-eabi-g++  arm-eabi-gcc-4.8.1  arm-eabi-gcc-nm      arm-eabi-gcov
#arm-eabi-cpp  arm-eabi-gcc  arm-eabi-gcc-ar     arm-eabi-gcc-ranlib

export curdir=${PWD}
export ARMROOT=${HOME}/armroot481   

source ${vdir}/victorset 
cd $curdir

export  PKG_CONFIG_PATH=${ARMROOT}/lib/pkgconfig
#export LL=${KUNPENG_SDK_ROOT}/armv5te-cisco-glibc-gnueabi/lib/libffi-3.0.12
#export LIBFFI_CFLAGS=-I${LL}/include
#e#xport LIBFFI_LIBS="-L${LL}/lib -lffi"
export cross_compiling=yes  #inserted by victor

export CFLAGS="-pipe -O2 -g -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE  -I$ARMROOT/include  $LIBFFI_CFLAGS   -I$KUNPENG_SDK_ROOT/include "    

export CXXFLAGS="${CFLAGS}"

export LDFLAGS=`xml2-config --libs `
export LDFLAGS="$LDFLAGS   -L$ARMROOT/lib  $LIBFFI_LIBS -L$KUNPENG_SDK_ROOT/lib  "


export PATH=${ARMROOT}/bin:$PATH
export LD_LIBRARY_PATH=${ARMROOT}/lib:$LD_LIBRARY_PATH
export PATH=$gccdir/bin:$KUNPENG_SDK_ROOT/armv5te-cisco-glibc-gnueabi/bin:${KUNPENG_SDK_ROOT}/bin:$PATH
export LD_LIBRARY_PATH=$gccdir/lib:$LD_LIBRARY_PATH:$KUNPENG_SDK_ROOT/armv5te-cisco-glibc-gnueabi/lib:${KUNPENG_SDK_ROOT}/lib



cd $1 
make clean
make distclean
libtoolize -f 

./autostrap
#arm-linux-gnueabi-gcc-4.8.1
CC=arm-eabi-gcc AR=${CC}-ar RANLIB=${CC}-ranlib SKIP_RMDIR_CHECK=yes  ./autogen.sh 
aclocal
autoconf
automake


CC=arm-eabi-gcc AR=${CC}-ar RANLIB=${CC}-ranlib SKIP_RMDIR_CHECK=yes  ./configure --target=arm-linux --mandir=${ARMROOT}/share/man --infodir=${ARMROOT}/share/info --datadir=${ARMROOT}/share --sysconfdir=/etc --localstatedir=/var/lib --build=armel-unknown-linux-gnu  --host=armel --prefix=${ARMROOT} 
 


make
make install
cd ..


