
unset curdir
unset ARMROOT
unset LL
unset CFLAGS
unset CXXFLAGS
unset LDFLAGS

export curdir=${PWD}
export ARMROOT=${HOME}/armroot

#source ./setenv

cd $curdir

export  PKG_CONFIG_PATH=${ARMROOT}/lib/pkgconfig
export LL=${KUNPENG_SDK_ROOT}/armv5te-cisco-glibc-gnueabi/lib/libffi-3.0.12
export LIBFFI_CFLAGS=-I${LL}/include
export LIBFFI_LIBS="-L${LL}/lib -lffi"
export cross_compiling=yes  #inserted by victor

export CFLAGS="-pipe -O2 -g -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE   -I$KUNPENG_SDK_ROOT/include  -I$ARMROOT/include  $LIBFFI_CFLAGS "   

export CXXFLAGS="${CFLAGS}"

export LDFLAGS=`xml2-config --libs `
export LDFLAGS="$LDFLAGS  -L$KUNPENG_SDK_ROOT/lib   -L$ARMROOT/lib  $LIBFFI_LIBS"

export PATH=$KUNPENG_SDK_ROOT/armv5te-cisco-glibc-gnueabi/bin:$PATH
export LD_LIBRARY_PATH=$KUNPENG_SDK_ROOT/armv5te-cisco-glibc-gnueabi/lib:$LD_LIBRARY_PATH:$ARMROOT/lib


export PATH=${ARMROOT}/bin:${KUNPENG_SDK_ROOT}/bin:$PATH
export LD_LIBRARY_PATH=${ARMROOT}/lib:${KUNPENG_SDK_ROOT}/lib:$LD_LIBRARY_PATH


cd $1 
make clean
make distclean
libtoolize -f 

./autostrap

CC=arm-cisco-linux-gnueabi-gcc AR=arm-cisco-linux-gnueabi-ar RANLIB=arm-cisco-linux-gnueabi-ranlib SKIP_RMDIR_CHECK=yes  ./autogen.sh 
aclocal
autoconf
automake

CC=arm-cisco-linux-gnueabi-gcc AR=arm-cisco-linux-gnueabi-ar RANLIB=arm-cisco-linux-gnueabi-ranlib SKIP_RMDIR_CHECK=yes   ac_cv_func_realloc_0_nonnull=yes  ac_cv_func_malloc_0_nonnull=yes   ./configure  --mandir=${ARMROOT}/share/man --infodir=${ARMROOT}/share/info --datadir=${ARMROOT}/share --sysconfdir=/etc --localstatedir=/var/lib --prefix=${ARMROOT} --build=x86_64-build_unknown-linux-gnu --host=armel --target=arm-cisco-linux-gnueabi





make
make install
cd ..


