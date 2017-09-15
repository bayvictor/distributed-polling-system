unset OOPT
unset BBDIR
unset BDIR
unset PKG_CONFIG_PATH

export OOPT=${HOME}/x86root
BBDIR="outdir_build__"$1
BDIR=`echo $BBDIR|sed -e 's|\.\/||g'`

export  PKG_CONFIG_PATH=${OOPT}/lib/pkgconfig
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$OOPT/lib
export PATH=${OOPT}/bin:$PATH
export LD_LIBRARY_PATH=${OOPT}/lib:$LD_LIBRARY_PATH

mkdir  $BDIR 
cd $BDIR 
./autogen
./bootstrap
libtoolize -f
aclocal
autoconf
automake

../$1/configure --prefix=${OOPT}   
make;make install



