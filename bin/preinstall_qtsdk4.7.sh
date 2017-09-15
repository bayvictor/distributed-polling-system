#Apart from a C++ compiler, a number of development libraries need to be present to enable Qt Creator to build your Qt applications. On Debian and Ubuntu, use the following command in a terminal to make sure they are installed:

  sudo apt-get install -y libglib2.0-dev libSM-dev libxrender-dev libfontconfig1-dev libxext-dev

#If you're using QtOpenGL, you'll also need OpenGL development files. You can use the following command to find out which packages to install:

  sudo apt-get install -y libgl-dev libglu-dev
#A
cd ~/src/cellphone      
git clone git://gitorious.org/wise-android/wise-apk-installer.git
git clone git://gitorious.org/android-n900/vendor_nitdroid_n900.git
git clone git://gitorious.org/wise-android/wise-apk-installer.git
#  find wise-apk-installer/
#  506  ls
mkdir qtcreator210
cd qtcreator210/
wget ftp://ftp.trolltech.com/qtcreator/qt-creator-linux-x86_64-opensource-2.1.0-beta1.bin
wget ftp://ftp.trolltech.com/qtcreator/qt-creator-2.1.0-beta1-src.tar.gz
#  511  ls
chmod +x *.bin
./qt-creator-linux-x86_64-opensource-2.1.0-beta1.bin 
wget ftp://ftp.trolltech.com/qtsdk/qt-sdk-linux-x86_64-opensource-2010.05.1.bin
chmod +x *.bin
./qt-sdk-linux-x86_64-opensource-2010.05.1.bin 
#  517  history

