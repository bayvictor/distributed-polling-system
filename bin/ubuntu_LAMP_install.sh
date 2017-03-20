sudo apt-get install -y apache2-dev python-dev
sudo apt-get install -y postgresql-server-dev-8.4
cd /home/vhuang/src/wsgi/mod_wsgi-2.5
./configure
make 
sudo make install

sudo cp /usr/lib/apache2/modules/mod_wsgi.so /etc/apache2/
sudo cp ~/src/social_project/httpd.conf /etc/apache2/
sudo apt-get install -y apache2 php5-mysql libapache2-mod-php5 mysql-server
