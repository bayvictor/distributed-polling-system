#export PKG_CONFIG_PATH=/opt/media/local/lib/pkgconfig

export QTDIR=$HOME/src/qt-everywhere-opensource-src-4.7.1


export PATH=${QTDIR}/bin:/opt/media/local/bin:/opt/media/local/sbin:/opt/media/local/nginx/sbin:~/bin:$PATH:/home/vhuang/src/gclient/svn/depot_tools:
export LD_LIBRARY_PATH=${QTDIR}/lib:/lib:/usr/lib:/opt/media/local/lib:/opt/media/local/nginx/lib:~/lib:$LD_LIBRARY_PATH
export QMAKESPEC=$QTDIR/mkspecs/linux-g++
export DISPLAY=:0.0

