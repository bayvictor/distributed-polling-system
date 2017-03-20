#!/bin/bash
#set -x
export PATH=$PATH:~/gclient/depot_tools/
ROOTFS=/
ARCH=arm
GOLDLD=/home/user/
export LD_LIBRARY_PATH=$ROOTFS/lib/
export INCLUDE_DIR=$ROOTFS/usr/include
export GYP_DEFINES="werror= target_arch=$ARCH sysroot=$ROOTFS disable_nacl=1 linux_use_tcmalloc=0 armv7=1 arm_neon=0 arm_thumb=1 arm_fpu=vfpv3-d16 v8_use_snapshot=false"
echo $GYP_CFLAGS
export CROSSTOOL=/scratchbox/compilers/arm-linux-gnueabi-gcc4.4.1-glibc2.11.1/bin/arm-none-linux-gnueabi
export CXX="$CROSSTOOL-g++ -B $GOLDLD"
export CXXFLAGS=${CXXFLAGS}" -idirafter $ROOTFS/usr/include"
export CFLAGS=${CFLAGS}" -idirafter $ROOTFS/usr/include"
export CC="$CROSSTOOL-gcc -B $GOLDLD"
export AR=$CROSSTOOL-ar
export AS=$CROSSTOOL-as
export RANLIB=$CROSSTOOL-ranlib
export LINK="$CXX"
gclient runhooks

#TODO: generate options of that config from GYP_DEFINES

pushd third_party/ffmpeg/patched-ffmpeg-mt
./configure --disable-ffmpeg --disable-ffplay --disable-ffserver --disable-ffprobe --enable-shared --disable-static --disable-debug --disable-network --disable-encoders --disable-decoders --disable-hwaccels --disable-muxers --disable-demuxers --disable-parsers --disable-bsfs --disable-protocols --disable-devices --disable-filters --disable-gpl --disable-bzlib --disable-zlib --enable-decoder=theora --enable-decoder=vorbis --enable-demuxer=ogg --enable-pthreads --enable-cross-compile --arch=arm --target-os=linux --enable-armvfp --disable-neon --cross-prefix=${CROSSTOOL}- --extra-cflags='-march=armv7-a -mtune=cortex-a8 -mfpu=vfpv3-d16 -mfloat-abi=softfp' --prefix=./chromium-ffmpeg --disable-armv6 --disable-armv6t2  --enable-decoder=vp8 --enable-pic 
mv config.h ../config/Chromium/linux/$ARCH
popd

time make -r -j4 BUILDTYPE=Release chrome 2>&1| tee chromium-arm-Release.log

