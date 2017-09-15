rm -fr ltmain.sh
rm -fr libtool
ln -s /home/vhuang/armroot/share/libtool/config/ltmain.sh ./ltmain.sh
ln -s ./libtool.arm ./libtool

#make distclean
unset LDFLAGS
unset curdir
unset ARMROOT
unset SRP_CFLAGS
unset CFLAGS
unset CXXFLAGS
unset ARMROOT

export curdir=${PWD}
export ARMROOT=${HOME}/armroot
unset new_withlibs 
export new_withlibs=" CXX=arm-cisco-linux-gnueabi-g++ \
      LD=arm-cisco-linux-gnueabi-ld \
      NM=arm-cisco-linux-gnueabi--nm \
        ../srp-1.3_last_debug02/configure.arm \
            --config-cache \
            --host=armel  \
            --with-libevent=$ARMROOT \
            --with-libxml2=$ARMROOT \
            --with-glib2=$ARMROOT \
            --with-ssl=$ARMROOT \
            --with-gsoap=$ARMROOT \
            --enable-shared \
            --disable-static \
            --enable-isis \
            --enable-proximity "
unset conf_rest
export conf_rest="CC=arm-cisco-linux-gnueabi-gcc AR=arm-cisco-linux-gnueabi-ar RANLIB=arm-cisco-linux-gnueabi-ranlib     ac_cv_func_realloc_0_nonnull=yes  ac_cv_func_malloc_0_\
nonnull=yes   SKIP_RMDIR_CHECK=yes  --mandir=${ARMROOT}/share/man --infodir=${ARMROOT}/share/info --datadir=${ARMROOT}/share v--sysconfdir=/etc --localstatedir=/var/lib --build=x86-cisco-linux-gnueabi ---host=armel --target=arm-cisco-linux-gnueabi --enable-srp --prefix=${ARMROOT} "
 


export SRP_CFLAGS="-I${curdir}/include -I${curdir}/bgp/src -I${curdir}/ip/src -I${curdir}/isis/src -I${curdir}/ospf/src/ospf-lib -I${curdir}/routing-libs/include -I${curdir}/proximity/include -I${curdir}/ospf/src/ospfv2 -I${curdir}/ospf/src/ospf-api/export/ -I${curdir}/ospf/src/ospfv3/ "
export SRP_LDFLAGS=" -L${curdir}/mainloop/src/.libs -L${curdir}/dht/src/.libs -L${curdir}/dht/clientlib/.libs -L${curdir}/common-libs/src/.libs -L${curdir}/ldbm2/src/.libs -L${curdir}/mbean/src/.libs -L${curdir}/cli/src/.libs -L${curdir}/cli/clientlib/.libs -L${curdir}/trace/src/.libs -L${curdir}/routing-libs/src/urib_api/.libs -L${curdir}/routing-libs/src/pmalloc/.libs -L${curdir}/routing-libs/src/.libs -L${curdir}/routing-libs/src/if_agent/.libs -L${curdir}/routing-libs/src/smm_api/.libs -L${curdir}/routing-libs/src/tx/.libs -L${curdir}/routing-libs/tests/.libs -L${curdir}/ippc/src/.libs -L${curdir}/box/src/.libs -L${curdir}/log/src/.libs -L${curdir}/ip/src/.libs -L${curdir}/ip/cli/.libs "
export CFLAGS="-pipe -O2 -g -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 "
export CFLAGS=" -I${ARMROOT}/include $SRP_CFLAGS $CFLAGS -DUSE_GCC_4_1_ATOMIC_BUILTINS -I.  "
export CXXFLAGS="${CFLAGS}"
export LDFLAGS=" --L${ARMROOT}/lib  -lroutinglibs -L${curdir}/dht/src ${SRP_LDFLAGS} -L/home/vhuang/armroot/lib -L${curdir}/dht/src/.libs -L/home/cisco-kunpeng-sdk-20130208/lib   -lxml2 -lz -lpthread -lm -lffi -lpmalloc -lrt -lroutinglibs -lifagent -lsrp_ui -luribapi -lsmmapi -lroutinglibs "
export PATH=${ARMROOT}/bin:$PATH
export LD_LIBRARY_PATH=${ARMROOT}/lib:$LD_LIBRARY_PATH


#CC=arm-cisco-linux-gnueabi-gcc AR=arm-cisco-linux-gnueabi-ar RANLIB=arm-cisco-linux-gnueabi-ranlib     ac_cv_func_realloc_0_nonnull=yes  ac_cv_func_malloc_0_nonnull=yes   SKIP_RMDIR_CHECK=yes ./configure.arm  --mandir=${ARMROOT}/share/man --infodir=${ARMROOT}/share/info --datadir=${ARMROOT}/share --sysconfdir=/etc --localstatedir=/var/lib --build=x86-cisco-linux-gnueabi ---host=armel --target=arm-cisco-linux-gnueabi --enable-srp --prefix=${ARMROOT}
${new_withlibs} ${conf_rest}

make;make install
 
cp ./dht/src/srpd $ARMROOT/bin

 
