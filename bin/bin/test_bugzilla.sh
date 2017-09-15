sudo cp /home/fog/bugzilla-4.4.tar.gz /var/www
cd /var/www
sudo tar -zxf bugzilla-4.4.tar.gz
cd bugzilla-4.4
sudo chown www-data:www-data * -R
sudo ./checksetp.pl

sudo /usr/bin/perl install-module.pl --all




