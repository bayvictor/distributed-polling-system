## for ubuntu 
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y libapache2-mod-wsgi
sudo apt-get install -y apache2-threaded-dev #2.2.11-2ubuntu2.3, resolve apxs
sudo apt-get install -y python-dev

# make 64 bit module
cd /home/vhuang/src/wsgi/mod_wsgi-2.5/
make distclean
./configure
make
sudo make install


## resolve_segm_fault_in_apache_log.sh
echo 'echo "fs.epoll.max_user_instances=4092" >> /etc/sysctl.conf'
sudo chmod +w /etc/sysctl.conf

## different version use diff line as 1 of 2 below:
sudo echo "fs.epoll.max_user_instances=4092" >> /etc/sysctl.conf
sudo echo "fs.inotify.max_user_instances=4092" >> /etc/sysctl.conf

sudo chmod -w /etc/sysctl.conf
sudo sysctl -p

## (1)prepare httd.conf, (2) in it calibrate wsgi python path
sudo cp /etc/apache2/httpd.conf /etc/apache2/httpd.conf.20100519
sudo chown vhuang /etc/apache2/httpd.conf
cp ~/src/pinax_scripts/httpd.conf /etc/apache2/httpd.conf
ls /home/vhuang/src/pinax-env/lib/python2.6/site-packages|head -n 2
ls /home/vhuang/src/mysite/deploy/pinax.wsgi |head -n 2

# clean err/access log first inside restartsudo echo "fs.epoll.max_user_instances=4092" >> /etc/sysctl.conf


~/src/apache_restart.sh

