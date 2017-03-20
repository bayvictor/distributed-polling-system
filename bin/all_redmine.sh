 preinstall_redmine.sh  
pre_redmine.sh 

ins_redmine.sh 
 ubu_install_redmine.sh
sudo tasksel  install -y  lamp-server
sudo apt-get  install -y  libapache2-mod-passenger -y 

sudo aa-complain /usr/sbin/mysqld
sudo apt-get  install -y  redmine redmine-mysql
 sudo add-apt-repository ppa:ondrej/redmine
 sudo apt-get update
 sudo apt-get  install -y  redmine redmine-mysql
 sudo ln -s /usr/share/redmine/public /var/www/redmine
 sudo aa-enforce /usr/sbin/mysqld
 sudo a2enmod passenger
 sudo service apache2 restart
 sudo chmod a+x /usr/share/redmine/public
 sudo apt-get  install -y  redmine redmine-mysql
 sudo service redmine start
 sudo service redmine stop
 sudo tasksel  install -y  lamp-server
 sudo aa-complain /usr/sbin/mysqld
 sudo apt-get  install -y  redmine redmine-mysql subversion
 sudo aa-enforce /usr/sbin/mysqld
 sudo ln -s /usr/share/redmine/public /var/www/redmine
 sudo ln -s /var/cache/redmine/default/plugin_assets /usr/share/redmine/public/

