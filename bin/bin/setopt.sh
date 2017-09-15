unset OOPT
unset BBDIR
unset BDIR
unset PKG_CONFIG_PATH

export OOPT=${HOME}/opt
export BBDIR="outdir_build__"$1
export BDIR=`echo $BBDIR|sed -e 's|\.\/||g'`

export  PKG_CONFIG_PATH=${OOPT}/lib/pkgconfig:/opt/lib/pkgconfig
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$OOPT/lib:/opt/lib
export PATH=${OOPT}/bin:/opt/bin:$PATH


