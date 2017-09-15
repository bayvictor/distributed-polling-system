#!/bin/bash

echo "#Compiling FFmpeg from upstream svn snapshots"

echo "      /!\ September 2008: Compiling from upstream may currently be broken if you choose to compile in encoding support for H264 (--enable-x264 option). libx264-dev shipped with Ubuntu 8.04 Hardy Heron is too old to compile FFmpeg. See this http://article.gmane.org/gmane.comp.video.mplayer.user/56828. The error message you might see includes "
echo "X264_ME_TESA' undeclared (first use in this function)" 

echo "For up to date instructions on installing the latest FFmpeg and x264 see HOWTO: Install and use the latest FFmpeg and x264 at the Ubuntu Forums.

please note that x264 is an *encoder*. FFmpeg does not need this library for playback. In fact, the ffmpeg version in ubuntu main has no problem with h264 playback.

Remove FFmpeg"

read read_line
sudo apt-get remove ffmpeg
sudo apt-get install -y  libfaad-dev
echo "Get pre-requisites"
apt-cache search  libfaad-dev 
sudo apt-get install -y  libfaad-dev 
sudo apt-get install -y libgsm1-dev libvorbis-dev libxvidcore4-dev libdc1394-22-dev libfaac-dev libmp3lame-dev libx264-dev libtheora-dev libsdl1.2-dev # libfaad-dev 
read read_line
sudo apt-get remove ffmpeg

echo "Grab the FFmpeg source"
read read_line


#wget http://ffmpeg.org/releases/ffmpeg-0.6.tar.bz2 
#wget http://ffmpeg.mplayerhq.hu/ffmpeg-export-snapshot.tar.bz2
#tar jxvf ffmpeg*.tar.bz2
#cd ffmpeg*

#or checkout the latest version from svn

sudo apt-get install -y SVN
svn co svn://svn.mplayerhq.hu/ffmpeg/trunk ffmpeg
cd ffmpeg

echo "Configure
"
#./configure --enable-gpl --enable-postproc --enable-swscale --enable-pthreads --enable-x11grab --enable-libdc1394 --enable-libfaad --enable-libgsm --enable-libmp3lame --enable-libtheora --enable-libvorbis --enable-libx264 --enable-libxvid # --enable-libfaac


./configure --enable-gpl --enable-postproc --enable-swscale --enable-pthreads --enable-x11grab --enable-libdc1394 --enable-libgsm --enable-libmp3lame --enable-libtheora --enable-libvorbis --enable-libx264 --enable-libxvid #
# --enable-libfaac  --enable-libfaad

echo "Compile"

make

Install

sudo checkinstall --fstrans=no --install=yes --pkgname=ffmpeg --pkgversion "3:0.svn`date +%Y%m%d`-12ubuntu3" --default



