

export curdir=${PWD}
export ARMROOT=${curdir}/armroot

export CFLAGS="-pipe -O2 -g -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 "
export CFLAGS="-L${ARMROOT}/lib -I${ARMROOT}/include $CFLAGS -DUSE_GCC_4_1_ATOMIC_BUILTINS -I.  "
export CXXFLAGS="${CFLAGS}"

export PATH=${ARMROOT}/bin:$PATH
export LD_LIBRARY_PATH=${ARMROOT}/lib:$LD_LIBRARY_PATH

cd $1 

make distclean
./autostrap
aclocal
autoconf
automake


CC=arm-cisco-linux-gnueabi-gcc AR=arm-cisco-linux-gnueabi-ar RANLIB=arm-cisco-linux-gnueabi-ranlib SKIP_RMDIR_CHECK=yes ./configure --target=arm-linux --mandir=${ARMROOT}/share/man --infodir=${ARMROOT}/share/info --datadir=${ARMROOT}/share --sysconfdir=/etc --localstatedir=/var/lib --build=armel-unknown-linux-gnu  --host=armel --prefix=${ARMROOT} 
 


make
make install
cd ..


