
unset curdir
export curdir=${PWD}
export ARMROOT=${HOME}//armroot
export cur=$curdir

export SRP_CFLAGS="-I$curdir/include -I$cur/bgp/src -I$cur/ip/src -I$cur/isis/src -I$cur/ospf/src/ospf-lib -I$cur/routing-libs/include  "  
export CFLAGS="${CFLAGS} -L${ARMROOT}/lib -I${ARMROOT}/include $SRP_CFLAGS -DUSE_GCC_4_1_ATOMIC_BUILTINS -I. -D__LINUX_ARM_ARCH__ "
export CXXFLAGS="${CFLAGS}"
export PATH=${ARMROOT}/bin:$PATH
export LD_LIBRARY_PATH=${ARMROOT}/lib:$LD_LIBRARY_PATH


CC=arm-cisco-linux-gnueabi-gcc AR=arm-cisco-linux-gnueabi-ar RANLIB=arm-cisco-linux-gnueabi-ranlib SKIP_RMDIR_CHECK=yes ./configure --target=arm-linux --mandir=/usr/share/man --infodir=/usr/share/info --datadir=/usr/share --sysconfdir=/etc --localstatedir=/var/lib --build=armeb-unknown-linux-gnu  --host=armv5 --prefix=${ARMROOT} --enable-srp 
 
make;make install


