sudo apt-get install -y libopenssl-ruby #- OpenSSL interface for Ruby
sudo apt-get install -y libapache2-mod-perl2-dev #- Integration of perl with the Apache2 web server #- development files

sudo apt-get install -y libmemcache-dev #- development headers for libmemcache C client API

sudo apt-get install -y apache2-prefork-dev #- Apache development headers #- non-threaded MPM
sudo apt-get install -y apache2-threaded-dev #- Apache development headers #- threaded MPM


sudo apt-get install -y apache-dev
gem install passenger
passenger-install-apache2-module

echo "If the second line does not work, do whereis passenger to find out where it is install
"

