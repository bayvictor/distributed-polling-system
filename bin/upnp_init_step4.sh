

mkdir ~/src/Downloads
cd ~/src/Downloads

wget http://mirrors.ibiblio.org/pub/mirrors/eclipse/technology/epp/downloads/release/helios/SR1/eclipse-jee-helios-SR1-linux-gtk.tar.gz



wget http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/helios/SR1/eclipse-jee-helios-SR1-linux-gtk.tar.gz&url=http://www.gtlib.gatech.edu/pub/eclipse/technology/epp/downloads/release/helios/SR1/eclipse-jee-helios-SR1-linux-gtk.tar.gz&mirror_id=337

echo "press any key when ready..."
read read_line

wget http://dl.google.com/android/ndk/android-ndk-r4b-linux-x86.zip
wget http://dl.google.com/android/android-sdk_r07-linux_x86.tgz 


sudo apt-get install -y filezilla

wget   ftp://ftp.trolltech.com/qt/source/qt-everywhere-opensource-src-4.7.1.tar.gz
cd qt-e*

./configure   -qt-zlib   -qt-libtiff   -qt-libpng  -qt-libmng  -qt-libjpeg  -openssl-linked  -developer-build  -platform linux-g++-64

make

sudo make install
sudo apt-get install -y libxrender-dev 
#Xrender

#apt-cache search libxrender
#libxrender-dev


