mkdir ~/src
mkdir ~/src/tor/
cd ~/src/tor/
sudo  apt-get install -y libevent-dev
sudo apt-get install -y libssl-devxf
read read_line
echo "willdo:  wget http://www.torproject.org/dist/tor-0.2.1.25.tar.gz"
  wget https://www.torproject.org/dist/torbrowser/linux/tor-browser-gnu-linux-x86_64-2.2.38-2-dev-en-US.tar.gz
# http://www.torproject.org/dist/tor-0.2.1.25.tar.gz
#  tar -zxvf tor-0.2.1.25.tar.gz 
tar -zxvf tor-browser-gnu-linux-x86_64-2.2.38-2-dev-en-US.tar.gz

  cd tor-0.2.1.25/
  ./configure
