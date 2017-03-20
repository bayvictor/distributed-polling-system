
unset curdir
unset ARMROOT
unset LL
unset CFLAGS
unset CXXFLAGS
unset LDFLAGS

export curdir=${PWD}
export ARMROOT=${HOME}/x86root

#source ./setenv

cd $curdir

export  PKG_CONFIG_PATH=${ARMROOT}/lib/pkgconfig
export LL=${KUNPENG_SDK_ROOT}/armv5te-cisco-glibc-gnueabi/lib/libffi-3.0.12
export LIBFFI_CFLAGS=-I${LL}/include
export LIBFFI_LIBS="-L${LL}/lib -lffi"
export cross_compiling=yes  #inserted by victor

export CFLAGS="-pipe -O2 -g -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE    -I$ARMROOT/include  $LIBFFI_CFLAGS "   

export CXXFLAGS="${CFLAGS}"

export LDFLAGS=`xml2-config --libs `
export LDFLAGS="$LDFLAGS    -L$ARMROOT/lib  $LIBFFI_LIBS"

export LD_LIBRARY_PATH=LD_LIBRARY_PATH:$ARMROOT/lib




cd $1 
make clean
make distclean
libtoolize -f 

./autostrap




CC=gcc AR=ar RANLIB=ranlib SKIP_RMDIR_CHECK=yes  ./autogen.sh 
aclocal
autoconf
automake


x86conf.sh


#CC=gcc AR=ar RANLIB=ranlib SKIP_RMDIR_CHECK=yes   ac_cv_func_realloc_0_nonnull=yes  ac_cv_func_malloc_0_nonnull=yes   ./configure  --mandir=${ARMROOT}/share/man --infodir=${ARMROOT}/share/info --datadir=${ARMROOT}/share --sysconfdir=/etc --localstatedir=/var/lib --prefix=${ARMROOT} --build=x86_64-build_unknown-linux-gnu --host=x86_64-build_unknown-linux-gnu --target=x86_64-build_unknown-linux-gnu

make
make install
cd ..



