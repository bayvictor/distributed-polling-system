#!/bin/sh
#cat setenv | cut -d"=" -f1 | sed 's/export /unset /g'


unset KUNPENG_SDK_ROOT
unset CROSS_COMPILE
unset CROSS_COMPILE


unset AR
unset AS
unset LD
unset NM
unset CC
unset GCC
unset CPP
unset CXX
unset READELF
unset RANLIB
unset STRIP
unset OBJCOPY
unset OBJDUMP
unset DEFAULT_ASSEMBLER
unset DEFAULT_LINKER
unset CFLAGS
unset CXXFLAGS
unset ARMROOT
unset LDFLAGS

export  ARMROOT=${HOME}//armroot

cd  $HOME/cisco-kunpeng-sdk-20130208

export KUNPENG_SDK_ROOT=`pwd`
export KUN=$KUNPENG_SDK_ROOT

unset CROSS_COMPILE
export CROSS_COMPILE=arm-cisco-linux-gnueabi-

export AR=${CROSS_COMPILE}ar
export AS=${CROSS_COMPILE}as
export LD=${CROSS_COMPILE}ld
export NM=${CROSS_COMPILE}nm
export CC=${CROSS_COMPILE}gcc
export GCC=${CROSS_COMPILE}gcc
export CPP=${CROSS_COMPILE}cpp
export CXX=${CROSS_COMPILE}g++
export READELF=${CROSS_COMPILE}readelf
export RANLIB=${CROSS_COMPILE}ranlib
export STRIP=${CROSS_COMPILE}strip
export OBJCOPY=${CROSS_COMPILE}objcopy
export OBJDUMP=${CROSS_COMPILE}objdump
export DEFAULT_ASSEMBLER=${CROSS_COMPILE}ar
export DEFAULT_LINKER=${CROSS_COMPILE}ld





export  PKG_CONFIG_PATH=${ARMROOT}/lib/pkgconfig

#export LL=${KUNPENG_SDK_ROOT}/armv5te-cisco-glibc-gnueabi/lib/libffi-3.0.12
export LL=$ARMROOT/lib/libffi-3.0.12
export LIBFFI_CFLAGS=-I$ARMROOT/lib/libffi-3.0.12/include 
export LIBFFI_LIBS="-L$ARMROOT/lib -lffi" 
export LDFLAGS=`xml2-config --libs ` 
export LDFLAGS="$LDFLAGS  -L$KUNPENG_SDK_ROOT/lib   -L$ARMROOT/lib  $LIBFFI_LIBS"  
export cross_compiling=yes  #inserted by victor

export PATH=$KUNPENG_SDK_ROOT/armv5te-cisco-glibc-gnueabi/bin:$PATH
export LD_LIBRARY_PATH=$KUNPENG_SDK_ROOT/armv5te-cisco-glibc-gnueabi/lib:$LD_LIBRARY_PATH:$ARMROOT/lib 


export PATH=${ARMROOT}/bin:${KUNPENG_SDK_ROOT}/bin:$PATH
export LD_LIBRARY_PATH=${ARMROOT}/lib:${KUNPENG_SDK_ROOT}/lib:$LD_LIBRARY_PATH



#export CFLAGS="-pipe -O2 -g -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -EL"
export CFLAGS="-pipe -O2 -g -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE  -I$ARMROOT/../glib-2.36.4  -I$KUNPENG_SDK_ROOT/include -I$ARMROOT/include  $LIBFFI_CFLAGS " 
export CXXFLAGS="${CFLAGS}"

export PKG_CONFIG_PATH=$ARMROOT/lib/pkgconfig    #lib/pkgconfig/ 


export COM="CC=arm-cisco-linux-gnueabi-gcc AR=arm-cisco-linux-gnueabi-ar RANLIB=arm-cisco-linux-gnueabi-ranlib SKIP_RMDIR_CHECK=yes  --mandir=${ARMROOT}/share/man --infodir=${ARMROOT}/share/info --datadir=${ARMROOT}/share --sysconfdir=/etc --localstatedir=/var/lib "


cd ~/victor

#cd  glib-2.36.4

