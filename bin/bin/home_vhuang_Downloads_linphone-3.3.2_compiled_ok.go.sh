sudo apt-get install -y libavbin-dev #- development files for libavbin
sudo apt-get install -y libdlna-dev #- development files for libdlna
sudo apt-get install -y libffmpegthumbnailer-dev #- development files for ffmpegthumbnailer
sudo apt-get install -y librtmp-dev #- toolkit for RTMP streams (development files)
sudo apt-get install -y libtaoframework-ffmpeg-cil-dev #- Tao CLI binding for FFmpeg #- development files
sudo apt-get install -y libvalhalla-dev #- a tiny media scanner library -- development files
sudo apt-get install -y libvalhalla-doc #- developer documentation for libvalhalla
sudo apt-get install -y libmpeg4ip-dev #- end-to-end system to explore streaming multimedia
sudo apt-get install -y libavcodec-dev #- development files for libavcodec
sudo apt-get install -y libavdevice-dev #- development files for libavdevice
sudo apt-get install -y libavdevice52 #- ffmpeg device handling library
sudo apt-get install -y libavfilter-dev #- development files for libavfilter
sudo apt-get install -y libavformat-dev #- development files for libavformat
sudo apt-get install -y libavutil-dev #- development files for libavutil
sudo apt-get install -y libpostproc-dev #- development files for libpostproc
sudo apt-get install -y libswscale-dev #- development files for libswscale
sudo apt-get install -y libavdevice-extra-52 #- ffmpeg device handling library
sudo apt-get install -y libavdevice-unstripped-52 #- ffmpeg utility library #- transitional package

sudo apt-get install -y gawk  
sudo apt-get install -y intltool
sudo apt-get install -y libv4l-dev
sudo apt-get install -y librtmp-dev # toolkit for RTMP streams (development files)
sudo apt-get install -y libavbin-dev # development files for libavbin
sudo apt-get install -y libdlna-dev # development files for libdlna
sudo apt-get install -y libffmpegthumbnailer-dev # development files for ffmpegthumbnailer
sudo apt-get install -y libffms2-dev # Development files for libffms2
sudo apt-get install -y libtaoframework-ffmpeg-cil-dev # Tao CLI binding for FFmpeg # development files
sudo apt-get install -y libvalhalla-dev # tiny media scanner library -- development files
sudo apt-get install -y libvalhalla-doc # developer documentation for libvalhalla

#apt-get source linphone
cd /home/vhuang/src/fusion/linphone-3.3.2
echo "^C to download first: linphone-3.3.2 and unzip first! if you have entered unzip folder,"
echo " press any key  to run this script to build & run!"
read readline

sudo apt-get install -y libv4l-dev; echo" - Collection of video4linux support libraries (development files)
"

sudo apt-get install -y libexosip2-dev; echo" - eXtended OSIP library development file";
sudo apt-get install -y libosip2-dev ; echo "- development files for the SIP library
"

sudo apt-get install -y libglade2-0 ; echo "- library to load .glade files at runtime" 
sudo apt-get install -y libglade2-dev ; echo "- development files for libglade
"

./autogen.sh
autoconf
automake
./configure
make
sudo make install
echo "^C to break; any key to run \"linphonec -V\" as below to enable video, no argument to disable video"
read readline
linphonec -V

