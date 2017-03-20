export CFLAGS="-pipe -O2 -g -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE   -I$KUNPENG_SDK_ROOT/include -L$KUNPENG_SDK_ROOT/lib   -I$ARMROOT/include -L$ARMROOT/lib  $LIBFFI_CFLAGS $LIBFFI_LIBS"

export CXXFLAGS="${CFLAGS}"

make distclean
unset curdir
export curdir=${PWD}
export ARMROOT=${curdir}/../armroot




export PATH=${ARMROOT}/bin:$PATH
export LD_LIBRARY_PATH=${ARMROOT}/lib:$LD_LIBRARY_PATH

libtoolize --ltdl --copy --force
#libtoolize -f

CC=arm-cisco-linux-gnueabi-gcc AR=arm-cisco-linux-gnueabi-ar RANLIB=arm-cisco-linux-gnueabi-ranlib SKIP_RMDIR_CHECK=yes ./configure --target=arm-linux --mandir=/usr/share/man --infodir=/usr/share/info --datadir=/usr/share --sysconfdir=/etc --localstatedir=/var/lib --build=armeb-unknown-linux-gnu  --host=armel --prefix=${ARMROOT} 
 

 
