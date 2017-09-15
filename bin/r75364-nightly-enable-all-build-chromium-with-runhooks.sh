#!/bin/bash
#set -x
#
export ENABLE_DEVICE_ORIENTATION=1
source ~/bin/set_env.sh
echo "do this outside scratchbox!: apt-get source libavformat-dev"
#apt-get source libavformat-dev
#read read_line
export AVDIR=${PWD}/third_party/ffmpeg/patched-ffmpeg-mt/libavcore
export BUILD_ROOT=${PWD}
export INCLUDE_DIR=/host_usr/include:${BUILD_ROOT}/third_party/ffmpeg/patched-ffmpeg-mt/libavcodec:${BUILD_ROOT}/third_party/bzip2:/opt/media/local/include:/usr/local/include:/usr/include:$ROOTFS/usr/include:
ls $AVDIR
ls 
#export PKG_CONFIG_PATH=/opt/media/local/lib/pkgconfig:$PKG_CONFIG_PATH

export PKG_CONFIG_PATH=${AVDIR}:$PKG_CONFIG_PATH

#/scratchbox/users/vhuang/home/vhuang/src/chromium/r75364-nightly-02182011/home/chrome-svn/tarball/chromium/src/third_party/ffmpeg/patched-ffmpeg-mt/libavcodec:$PKG_CONFIG_PATH

ROOTFS=/
ARCH=arm
GOLDLD=/opt/media/local/bin/ld
export LD_LIBRARY_PATH=$ROOTFS/lib:/opt/media/local/lib:/lib:/usr/local/lib
export GYP_DEFINES="werror= target_arch=$ARCH sysroot=$ROOTFS disable_nacl=1 linux_use_tcmalloc=0 armv7=1 arm_neon=0 arm_thumb=1 arm_fpu=vfpv3-d16 v8_use_snapshot=false"
echo $GYP_CFLAGS
export CROSSTOOL=/scratchbox/compilers/arm-linux-gnueabi-gcc4.4.1-glibc2.11.1/bin/arm-none-linux-gnueabi
export CXX="$CROSSTOOL-g++ -B $GOLDLD"
export CXXFLAGS=${CXXFLAGS}" -idirafter /usr/include  -idirafter /opt/medial/local/include  "
export CFLAGS=${CFLAGS}" -idirafter /usr/include -idirafter /opt/medial/local/include  "
export CC="$CROSSTOOL-gcc -B $GOLDLD"
export AR=$CROSSTOOL-ar
export AS=$CROSSTOOL-as
export RANLIB=$CROSSTOOL-ranlib
export LINK="$CXX"
gclient runhooks
source ~/bin/set_env.sh

export HAVE_SYMVER=1
# fix error" libffmpegsumo.so: version node not found for symbol av_init_packet@LIBAVFORMA

#TODO: generate options of that config from GYP_DEFINES

pushd third_party/ffmpeg/patched-ffmpeg-mt

env CFLAGS="${CFLAGS}" ./configure --disable-everything --enable-ffmpeg --enable-ffplay --enable-ffserver --enable-ffprobe --enable-shared --disable-static --disable-debug --enable-network --disable-encoders --disable-decoders --enable-hwaccels --disable-muxers --disable-demuxers --enable-parsers --enable-bsfs --enable-protocols  --disable-filters --enable-gpl --enable-bzlib --enable-zlib --enable-decoder=theora --enable-decoder=vorbis  --enable-decoder=ogg  --enable-decoder=mp4video  --enable-decoder=mp3 --enable-decoder=libx264 --enable-decoder=libx264 --enable-decoder=x264 --enable-demuxer=ogg --enable-pthreads --enable-cross-compile --arch=arm --target-os=linux --enable-armvfp --enable-neon --cross-prefix=${CROSSTOOL}- --extra-cflags='-march=armv7-a -mtune=cortex-a8 -mfpu=vfpv3-d16 -mfloat-abi=softfp' --prefix=./chromium-ffmpeg --disable-armv6 --disable-armv6t2  --enable-decoder=vp8 --enable-pic 


#env CFLAGS=${CFLAGS}${INCLUDE_DIR} ./configure --enable-everything --enable-ffmpeg --enable-ffplay --enable-ffserver --enable-ffprobe --enable-shared --disable-static --disable-debug --enable-network --enable-encoders --enable-decoders --enable-hwaccels --enable-muxers --enable-demuxers --enable-parsers --enable-bsfs --enable-protocols --enable-devices --disable-filters --enable-gpl --enable-bzlib --enable-zlib --enable-decoder=theora --enable-decoder=vorbis --enable-demuxer=ogg --enable-pthreads --enable-cross-compile --arch=arm --target-os=linux --enable-armvfp --enable-neon --cross-prefix=${CROSSTOOL}- --extra-cflags='-march=armv7-a -mtune=cortex-a8 -mfpu=vfpv3-d16 -mfloat-abi=softfp' --prefix=./chromium-ffmpeg --disable-armv6 --disable-armv6t2  --enable-decoder=vp8 --enable-pic 
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
#git clone git://gitorious.org/~astrange/ffmpeg/ffmpeg-mt.git  # multi-thread decoding..

echo "^c break to build ffmpg..."
#read read_line


echo "will to make -r -j 4 ..."
time make -r -j4 BUILDTYPE=Release chrome 2>&1| tee chromium.log

