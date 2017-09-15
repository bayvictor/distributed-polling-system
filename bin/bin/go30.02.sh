#make distclean
unset LDFLAGS
unset curdir
unset ARMROOT
unset SRP_CFLAGS

export curdir=${PWD}
export ARMROOT=${HOME}//armroot

export SRP_CFLAGS="-I$curdir/include -I$cur/bgp/src -I$cur/ip/src -I$cur/isis/src -I$cur/ospf/src/ospf-lib -I$cur/routing-libs/include -I$cur/proximity/include -I$cur/ospf/src/ospfv2 -I$cur/ospf/src/ospf-api/export/ -I$cur/ospf/src/ospfv3/ "
export SRP_LDFLAGS=" -L${curdir}/mainloop/src/.libs -L${curdir}/dht/src/.libs -L${curdir}/dht/clientlib/.libs -L${curdir}/common-libs/src/.libs -L${curdir}/ldbm2/src/.libs -L${curdir}/mbean/src/.libs -L${curdir}/cli/src/.libs -L${curdir}/cli/clientlib/.libs -L${curdir}/trace/src/.libs -L${curdir}/routing-libs/src/urib_api/.libs -L${curdir}/routing-libs/src/pmalloc/.libs -L${curdir}/routing-libs/src/.libs -L${curdir}/routing-libs/src/if_agent/.libs -L${curdir}/routing-libs/src/smm_api/.libs -L${curdir}/routing-libs/src/tx/.libs -L${curdir}/routing-libs/tests/.libs -L${curdir}/ippc/src/.libs -L${curdir}/box/src/.libs -L${curdir}/log/src/.libs -L${curdir}/ip/src/.libs -L${curdir}/ip/cli/.libs "
export CFLAGS="-pipe -O2 -g -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 "
export CFLAGS="-L${ARMROOT}/lib -I${ARMROOT}/include $SRP_CFLAGS $CFLAGS -DUSE_GCC_4_1_ATOMIC_BUILTINS -I.  "
export CXXFLAGS="${CFLAGS}"
export LDFLAGS="-L${curdir}/dht/src ${SRP_LDFLAGS} -L/home/vhuang/armroot/lib -L$cur/dht/src/.libs -L/home/vhuang/cisco-kunpeng-sdk-20130208/lib   -lxml2 -lz -lpthread -lm -lffi -lpmalloc -lrt -lroutinglibs -lifagent -lsrp_ui -luribapi -lsmmapi -lroutinglibs "
export PATH=${ARMROOT}/bin:$PATH
export LD_LIBRARY_PATH=${ARMROOT}/lib:$LD_LIBRARY_PATH
#--build=x86_64-build_unknown-linux-gnu --host=armel --target=arm-cisco-linux-gnueabi

ln -s  /home/vhuang/armroot/lib /home/vhuang/armroot/lib/.libs

# before copying make the libs latest avoiding recycling compiling 
# touch $curdir/routing-libs/src/.libs/libroutinglibs.la
# touch $curdir/routing-libs/src/.libs/libroutinglibs.a
 touch $curdir/routing-libs/src/.libs/lib*.*a
cp  $curdir/routing-libs/src/.libs/lib*.*a  $ARMROOT/lib


# touch $curdir/dht/src/libsrp_io.la
# touch $curdir/dht/src/libsrp_io.a

# touch $curdir/dht/src/libsrp_ui.la
# touch $curdir/dht/src/libsrp_ui.a

# touch $curdir/dht/src/.libs/libsrp_ui.a 
# touch $curdir/dht/src/.libs/libsrp_ui.la 
# touch $curdir/dht/src/libsrp_ui.la
# touch $curdir/dht/src/libsrp_ui.a
# touch  $curdir/dht/src/lib*.*a 
 touch  $curdir/routing-libs/src/.libs/*.*a 
 cp  $curdir/routing-libs/src/.libs/*.*a  $ARMROOT/lib 

# touch $curdir/routing-libs/src/urib_api/.libs/lib*.*a 

# touch $curdir/routing-libs/src/urib_api/.libs/liburibapi.a
# touch $curdir/routing-libs/src/urib_api/.libs/liburibapi.la
  
 touch $curdir/routing-libs/src/smm_api/.libs/lib*.*a
 cp  $curdir/routing-libs/src/smm_api/.libs/lib*.*a

 touch  $curdir/routing-libs/src/urib_api/.libs/lib*.*a 
 cp  $curdir/routing-libs/src/urib_api/.libs/lib*.*a $ARMROOT/lib

 touch $curdir/dht/src/lib*.*a 
 cp $curdir/dht/src/lib*.*a $curdir/dht/src/.libs/
# cp $curdir/dht/src/libsrp_io.*a $curdir/dht/src/.libs/
# cp $curdir/dht/src/libsrp_ui.*a $curdir/dht/src/.libs/
# cp $curdir/dht/src/.libs/libsrp_ui.*a  $ARMROOT/lib  
 touch $curdir/dht/src/.libs/lib*.*a
 cp $curdir/dht/src/.libs/lib*.*a  $ARMROOT/lib  

 touch $curdir/dht/src/lib*.*a 
 cp  $curdir/dht/src/lib*.*a  $ARMROOT/lib

# cp $curdir/dht/src/libsrp_ui.*a $ARMROOT/lib


# cp   $curdir/routing-libs/src/.libs/libroutinglibs.*a  $ARMROOT/lib  
 cp   $curdir/routing-libs/src/.libs/*.*a    $ARMROOT/lib 



CC=arm-cisco-linux-gnueabi-gcc AR=arm-cisco-linux-gnueabi-ar RANLIB=arm-cisco-linux-gnueabi-ranlib    ac_cv_func_realloc_0_nonnull=yes  ac_cv_func_malloc_0_nonnull=yes    SKIP_RMDIR_CHECK=yes ./configure  --mandir=${ARMROOT}/share/man --infodir=${ARMROOT}/share/info --datadir=${ARMROOT}/share --sysconfdir=/etc --localstatedir=/var/lib --build=x86_64-build_unknown-linux-gnu --host=armel --target=arm-cisco-linux-gnueabi --enable-srp --prefix=${ARMROOT}



make;make install
 
 
cp ./dht/src/srpd $ARMROOT/bin

 
