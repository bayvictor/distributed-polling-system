 sudo apt-get install -y --force-yes libtiff-opengl #- TIFF manipulation and conversion tools
 sudo apt-get install -y --force-yes libtiff5-dev #- TIFF manipulation and conversion tools


unset CURPATH
export CURPATH=$PWD 
mkdir ~/src
mkdir ~/src/lstm
cd ~/src/lstm



#wget http://www.leptonica.com/source/leptonica-1.74.4.tar.gz
#tar -zxf  leptonica-1.74.4.tar.gz
#sudo apt-get install -y --force-yes liblept4 #- image processing library
cd leptonica*
./autobuild
./configure

./localbuild.sh

./configure 
make;sudo make install
cd ..
cmake ..
cd /usr/local/lib
  sudo ln -s libleptonica.so liblept.so
cd $CURPATH

apt-get source  tesseract-ocr
#sudo apt-get install tesseract-ocr -y 
cd tesseract-3.03.02/
 ./autogen.sh 
 ./configure
make 
sudo make install

