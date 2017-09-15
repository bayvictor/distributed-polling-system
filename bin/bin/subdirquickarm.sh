unset curdir
#unset ARMROOT
unset LL
unset CFLAGS
unset CXXFLAGS
unset LDFLAGS

export curdir=${PWD}
#export ARMROOT=${HOME}/armroot

#source ~/setenv
cd $curdir

export  PKG_CONFIG_PATH=${ARMROOT}/lib/pkgconfig
export LL=${KUNPENG_SDK_ROOT}/armv5te-cisco-glibc-gnueabi/lib/libffi-3.0.12
export LIBFFI_CFLAGS=-I${LL}/include
export LIBFFI_LIBS="-L${LL}/lib -L$ARMROOT/lib -lffi"
export cross_compiling=yes  #inserted by victor

export LDFLAGS=`xml2-config --libs `
export LDFLAGS="$LDFLAGS  -L$KUNPENG_SDK_ROOT/lib   -L$ARMROOT/lib  $LIBFFI_LIBS"

export CFLAGS="-pipe -O2 -g -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE   -I$KUNPENG_SDK_ROOT/include -L$KUNPENG_SDK_ROOT/lib   -I$ARMROOT/include -L$ARMROOT/lib  $LIBFFI_CFLAGS $LIBFFI_LIBS -lrt"

export CXXFLAGS="${CFLAGS}"

export PATH=$KUNPENG_SDK_ROOT/armv5te-cisco-glibc-gnueabi/bin:$PATH
export LD_LIBRARY_PATH=$KUNPENG_SDK_ROOT/armv5te-cisco-glibc-gnueabi/lib:$LD_LIBRARY_PATH:$ARMROOT/lib


export PATH=${ARMROOT}/bin:${KUNPENG_SDK_ROOT}/bin:$PATH
export LD_LIBRARY_PATH=${ARMROOT}/lib:${KUNPENG_SDK_ROOT}/lib:$LD_LIBRARY_PATH

cd $1 

#make distclean
#libtoolize -f 
export COM="CC=arm-cisco-linux-gnueabi-gcc AR=arm-cisco-linux-gnueabi-ar RANLIB=arm-cisco-linux-gnueabi-ranlib SKIP_RMDIR_CHECK=yes  --mandir=${ARMROOT}/share/man --infodir=${ARMROOT}/share/info --datadir=${ARMROOT}/share --sysconfdir=/etc --localstatedir=/var/lib "
echo "CTRIPLE={$CTRIPLE}"
CC=arm-cisco-linux-gnueabi-gcc AR=arm-cisco-linux-gnueabi-ar RANLIB=arm-cisco-linux-gnueabi-ranlib SKIP_RMDIR_CHECK=yes   ac_cv_func_realloc_0_nonnull=yes  ac_cv_func_malloc_0_nonnull=yes   ./configure  --mandir=${ARMROOT}/share/man --infodir=${ARMROOT}/share/info --datadir=${ARMROOT}/share --sysconfdir=/etc --localstatedir=/var/lib --prefix=${ARMROOT} --build=x86_64-build_unknown-linux-gnu --host=armel --target=arm-cisco-linux-gnueabi  
 
make
make install
cd ..

