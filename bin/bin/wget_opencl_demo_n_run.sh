sudo apt-get install -y boinc-amd-opencl #- metapackage for AMD/ATI OpenCL-savvy BOINC client and manager
sudo apt-get install -y python-pyopencl #- module to access OpenCL parallel computation API
sudo apt-get install -y opencl-headers #- OpenCL (Open Computing Language) header files


sudo apt-get install -y qt3-dev-tools
sudo apt-get install -y  qt4-qmake
mkdir  /home/vhuang/src/opencl/demo
cd /home/vhuang/src/opencl/demo
wget http://svn.clifford.at/tools/trunk/examples/cldemo.c
mv cldemo.c cldemo.cpp
qmake -project
qmake
make
sudo ls
g++ -m64 -Wl,-O1 -o demo cldemo.o   -L/usr/lib/x86_64-linux-gnu -lOpenCL

