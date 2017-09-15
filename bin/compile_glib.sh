# export PKG_CONFIG_PATH=/usr/local/Cellar/libffi/3.0.11/lib/pkgconfig/ 
unset PKG_CONFIG_PATH

export  PKG_CONFIG_PATH=${ARMROOT}/lib/pkgconfig   
export LL=${KUNPENG_SDK_ROOT}/armv5te-cisco-glibc-gnueabi/lib/libffi-3.0.12

#export LIBFFI_CFLAGS=-I/home/user/localroot/lib/libffi-3.0.11/include
#export LIBFFI_LIBS="-L/home/user/localroot/lib -lffi"
#ibffi.so

export LIBFFI_CFLAGS=-I${LL}/include 
export LIBFFI_LIBS="-L${LL}/lib -lffi"  


# subdirquickarm.sh libffi-3.0.12/
subdirquickarm.sh  glib-2.36.4


