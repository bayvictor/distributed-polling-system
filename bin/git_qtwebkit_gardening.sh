echo "Goals

    Trunk must build on all of our platform
    Don't bring regressions into the tree
    Buildbots should be green almost at all times 

First steps before gardening

    Get Ubuntu 12.04 or 12.10 and install it. Install this metapackage: ​https://launchpad.net/~u-szeged/+archive/sedkit

     * "
sudo apt-get -y  -y  install python-software-properties
sudo add-apt-repository ppa:u-szeged/sedkit
sudo apt-get -y  -y  update
sudo apt-get -y  install sedkit-env-qtwebkit

echo "    Install GStreamer 1.0 (Will be mandatory soon, see ​https://bugs.webkit.org/show_bug.cgi?id=106669 for details)

     * "

sudo add-apt-repository ppa:gstreamer-developers/ppa
sudo apt-get -y  update
sudo apt-get -y  install gstreamer1.0 libgstreamer-plugins-base1.0-dev

echo "    Build the actual Qt 5 for the WebKit trunk with this builder script:

     *"
cd ~/src

git clone git://github.com/ossy-szeged/qt5-tools.git
./build-qt5.sh 


echo "
     * If there is Qt5 update, then the only thing left is to use git pull and run the script again.

     note:
     * build-qt5.sh uses 30 threads by default (-j option) 
     * Qt is installed into /usr/local/Trolltech (normal user doesn't have write permission for it by default

    Download testfonts, set environment variables (note: the latest suffix of QTDIR is QT_WEEKLY_REV in ​build-qt5-env)

     * "

git clone git://gitorious.org/qtwebkit/testfonts.git
 export WEBKIT_TESTFONTS=/home/webkit/testfonts
 export TZ=America/Los_Angeles #( to make all JSC tests pass :) )
 export QTDIR=/usr/local/Trolltech/Qt5/Qt-5.0.0-beta1
 export PATH=/usr/local/Trolltech/Qt5/Qt-5.0.0-beta1/bin:$PATH

echo "    Download WebKit, configure git svn, build WebKit.

     * "
git clone git://git.webkit.org/WebKit.git WebKit
cd WebKit
git svn init --prefix=origin/ -T trunk http://svn.webkit.org/repository/webkit
git config --replace svn-remote.svn.fetch trunk:refs/remotes/origin/master
git svn fetch

echo "     * to build: Tools/Scripts/build-webkit (Set MAKEFLAGS=-j5) 

    You are ready for Gardening. ;) 
"
Tools/Scripts/build-webkit MAKEFLAGS=-j5

