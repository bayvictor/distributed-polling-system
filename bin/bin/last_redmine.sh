echo "run it as root!"
read readline

sudo apt-get install -y redmine #- flexible project management web application
sudo apt-get install -y redmine-mysql #- metapackage providing MySQL dependencies for Redmine
sudo apt-get  install -y  libapache2-mod-passenger -y 
sudo a2enmod passenger
source ~/bin/preinstall_redmine.sh

 ./ins_redmine.sh 
# dpkg-reconfigure -plow redmine
./all_redmine.sh 

