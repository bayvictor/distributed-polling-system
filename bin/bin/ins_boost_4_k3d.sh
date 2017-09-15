sudo apt-get install -y -y libsigc++-2.0-dev libboost-dev 
sudo apt-get install -y -y  libboost-dev 
sudo apt-get install -y -y  libboost-python1.40-dev #!- Boost.Python Library development files
sudo apt-get install -y -y  libboost-python1.40.0 #- Boost.Python Library
sudo apt-get install -y -y  libboost-regex-dev #- regular expression library for C++ (default version)
sudo apt-get install -y -y   libboost-date-time1.42-dev 

sudo apt-get install -y -y libboost-program-options1.42-dev   # program options library for C++
sudo apt-get install -y -y libboost-program-options-dev   # program options library for C++ (default version)
sudo apt-get install -y -y libboost-python-dev   # Boost.Python Library development files (default version)
sudo apt-get install -y -y libboost-python1.42-dev   # Boost.Python Library development files
sudo apt-get install -y -y libboost-mpi-python1.40-dev   # C++ interface to the Message Passing Interface (MPI), Python Bindings
sudo apt-get install -y -y libboost-python1.40-dev   # Boost.Python Library development files
sudo apt-get install -y -y python-llvm   # Python bindings for LLVM
sudo apt-get install -y -y python-mapnik   # C++/Python toolkit for developing GIS applications (Python)
sudo apt-get install -y -y python-pykaraoke   # free CDG/MIDI/MPEG karaoke player
sudo apt-get install -y -y python-yapgvb   # Python bindings for Graphviz, using Boost.Python
sudo apt-get install -y -y libboost-test-dev   # components for writing and executing test suites (default version)
sudo apt-get install -y -y libboost-test1.42-dev   # components for writing and executing test suites


rm ../k3d-bart/CMakeCache.txt  
 cmake ../k3d-bart  > build.log.txt



