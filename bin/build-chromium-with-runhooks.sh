#!/bin/bash
#set -x
#

echo "do this outside scratchbox!: apt-get source libavformat-dev"
apt-get source libavformat-dev
#read read_line
apt-get install -y e2fslibs

export BUILD_ROOT=/home/vhuang/src/chromium/r75218/home/chrome-svn/tarball/chromium/src
export INCLUDE_DIR=$ROOTFS/usr/include:${BUILD_ROOT}/third_party/bzip2:/opt/media/local/include


ROOTFS=/
ARCH=arm
GOLDLD=/opt/media/local/bin/ld
export LD_LIBRARY_PATH=$ROOTFS/lib/
export GYP_DEFINES="werror= target_arch=$ARCH sysroot=$ROOTFS disable_nacl=1 linux_use_tcmalloc=0 armv7=1 arm_neon=0 arm_thumb=1 arm_fpu=vfpv3-d16 v8_use_snapshot=false"
echo $GYP_CFLAGS
export CROSSTOOL=/scratchbox/compilers/arm-linux-gnueabi-gcc4.4.1-glibc2.11.1/bin/arm-none-linux-gnueabi
export CXX="$CROSSTOOL-g++ -B $GOLDLD"
export CXXFLAGS=${CXXFLAGS}" -idirafter $ROOTFS/usr/include  -idirafter /opt/medial/local/include  "
export CFLAGS=${CFLAGS}" -idirafter $ROOTFS/usr/include -idirafter /opt/medial/local/include  "
export CC="$CROSSTOOL-gcc -B $GOLDLD"
export AR=$CROSSTOOL-ar
export AS=$CROSSTOOL-as
export RANLIB=$CROSSTOOL-ranlib
export LINK="$CXX"
gclient runhooks
source ~/src/set_env.sh

export HAVE_SYMVER=1
# fix error" libffmpegsumo.so: version node not found for symbol av_init_packet@LIBAVFORMA

#TODO: generate options of that config from GYP_DEFINES

pushd third_party/ffmpeg/patched-ffmpeg-mt
env CFLAGS=${CFLAGS}"/usr/include" ./configure --disable-everything --disable-ffmpeg --disable-ffplay --disable-ffserver --disable-ffprobe --enable-shared --disable-static --disable-debug --disable-network --disable-encoders --disable-decoders --disable-hwaccels --disable-muxers --disable-demuxers --disable-parsers --disable-bsfs --disable-protocols --disable-devices --disable-filters --disable-gpl --disable-bzlib --disable-zlib --enable-decoder=theora --enable-decoder=vorbis --enable-demuxer=ogg --enable-pthreads --enable-cross-compile --arch=arm --target-os=linux --enable-armvfp --disable-neon --cross-prefix=${CROSSTOOL}- --extra-cflags='-march=armv7-a -mtune=cortex-a8 -mfpu=vfpv3-d16 -mfloat-abi=softfp' --prefix=./chromium-ffmpeg --disable-armv6 --disable-armv6t2  --enable-decoder=vp8 --enable-pic 
echo "./configure runs OK! ^c to break, anykey to mv config.sh"

#read read_line
mv config.h ../config/Chromium/linux/$ARCH
ls ../config/Chromium/linux/$ARCH/config.h
echo "will do \"popd\"..."
#read read_line
popd

echo "going to :apt-get source FFmpeg"
#read read_line

#apt-get source FFmpeg
git clone git://gitorious.org/~astrange/ffmpeg/ffmpeg-mt.git  # multi-thread decoding..

echo "^c break to build ffmpg..."
#read read_line


echo "will to make -r -j 4 ..."
time make -r -j4 BUILDTYPE=Release chrome 2>&1| tee chromium.log

