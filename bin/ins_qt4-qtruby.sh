# Ubuntu 10.04
# rvm 1.0.14
sudo aptitude install -y libqt4-core libqt4-dev cmake automoc
# from http://rubyforge.org/projects/korundum/
#wget http://rubyforge.org/frs/download.php/71843/qt4-qtruby-2.1.0.tar.gz
mkdir ~/src/cmake/qtruby
cd ~/src/cmake/qtruby
wget http://rubyforge.org/frs/download.php/75633/qt4-qtruby-2.2.0.tar.gz
tar -xvzf qt4-qtruby-2.2.0.tar.gz
cd qt4-qtruby-2.2.0
# the qtruby install -y uses the location of your ruby binary
rvm use 1.9.2
cmake .
make
sudo make install
# ubuntu doesn't look here by default, but the qtruby install puts its libraries here
sudo ldconfig /usr/local/lib
# we had to run make install with root because it writes to /usr/local/lib, but it also writes to $MY_RUBY_HOME.
# we don't want root-owned files floating around in there
export MY_RUBY_HOME=~/.ruby_versions/jruby-1.9.2

sudo chown -R $USER:$USER $MY_RUBY_HOME

