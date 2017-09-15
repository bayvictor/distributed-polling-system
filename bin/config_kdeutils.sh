cd ~/src
#sudo ln -s /usr/include/qt4/phonon /usr/include/KDE/Phonon
sudo apt-get --reinstall install libqt4-phonon-dev #fix PHONON not found
sudo apt-get install -y openssl libssl-dev mysql-server mysql-client libmysqlclient15-dev libmysql++-dev libreadline5-dev zlib1g-dev libbz2-dev
#above for bz2 not found issue
sudo apt-get install -y boost #fix "cmake boost not found
sudo ln -s /usr/lib/libaspell.so.15 /usr/lib/libaspell.so

sudo apt-get install -y libboost-date-time-dev libboost-date-time1.34.1 libboost-dev libboost-doc libboost-filesystem-dev libboost-filesystem1.34.1 libboost-graph-dev libboost-graph1.34.1 libboost-iostreams-dev libboost-iostreams1.34.1 libboost-program-options-dev libboost-program-options1.34.1 libboost-python-dev libboost-python1.34.1 libboost-regex-dev libboost-regex1.34.1 libboost-signals-dev libboost-signals1.34.1 libboost-test-dev libboost-test1.34.1 libboost-thread-dev libboost-thread1.34.1
## libaspell-dev fix cmake 'Could NOT find ASPELL  (missing:  ASPELL_LIBRARIES ASPELL_INCLUDE_DIR'
sudo apt-get install -y libaspell-dev
svn co svn://anonsvn.kde.org/home/kde/trunk/KDE/kdeutils/ -N
cd kdeutils

svn co svn://anonsvn.kde.org/home/kde/trunk/KDE/kdeutils/ark
cd ark
cmake . && make && make install 
cd ..
cmake . && make && make install 
#svn co svn://anonsvn.kde.org/home/kde/trunk/KDE/kdeutils/cmake
#mkdir build && cd build
#cd cmake
#cmake ..  && make && make install 
#-I /usr/include/qt4/Qt