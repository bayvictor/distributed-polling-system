sudo apt-get install -y zlib1g-dev #- compression library #- development

./configure -developer-build -opensource -nomake examples -nomake tests  -qt-zlib    -qt-libpng    -qt-libjpeg  -openssl-linked  -shared -opengl   -debug-and-release
