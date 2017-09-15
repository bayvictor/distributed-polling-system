echo "HowTos »
HowTo Install Redmine 212 in Ubuntu 1210 and Apache Passenger


Inspired in \"HowTo Install Redmine 210 on Debian Squeeze with Apache Passenger\", from this same wiki, so meta-kudos, to the original authors.
Assumptions

    We will be using redmine.example.com; so every time you see this below, replace it by your own domain
"

echo "    For this to work maybe you shold edit /etc/hosts file adding a line \"127.0.0.1 redmine.example.com\"
    If you are behind a proxy, you could do export http_proxy=\"http://proxy.domain.tld:port\" and the installation should work ok.

Warming up

We will first need to install basic packages:
apt-get install ruby rubygems libruby libapache2-mod-passenger ruby-dev
"

echo "^ to break, anykey to contiue...."; read readline

echo "^C to break, anykey to contiue...."; read readline



apt-get install ruby rubygems libruby libapache2-mod-passenger ruby-dev


echo  "Download the latest version of Redmine (2.1.2 in our case) and untar it, then move it to /usr/local/share
"

echo "^ to break, anykey to contiue...."; read readline



cd /usr/local/share/
wget http://rubyforge.org/frs/download.php/76495/redmine-2.1.2.tar.gz
tar -xzvf redmine-2.1.2.tar.gz
ln -s /usr/local/share/redmine-2.1.2 /usr/local/share/redmine
chown -R root:root /usr/local/share/redmine-2.1.2

echo "Install development libraries for MySQL and Imagick:
apt-get install libmysqlclient-dev libmagickcore-dev libmagickwand-dev (install shitload of packages)
"
apt-get install libmysqlclient-dev libmagickcore-dev libmagickwand-dev #(install shitload of packages)


echo "^ to break, anykey to contiue...."; read readline

echo "^C to break, anykey to contiue...."; read readline

echo "Running the Gem stuff

Install Bundler (removing useless module, which would otherwise create dependencies):
"

gem install bundler
cd /usr/local/share/redmine/
bundle install --without development test postgresql sqlite

echo "Creating the database

On a new installation you need to create the database and a user for redmine.

mysql -u root -p
echo \"At the mysql prompt enter the mysql commands:

create database redmine;
create user 'redmine' identified by 'redmine';
set password for 'redmine'@'localhost' = password('my_password');
grant all on *.* to 'redmine'@'localhost';

quit;

Configuration

Copy config/database.yml.example to config/database.yml and edit this file in order to configure your database settings for \"production\" environment.
Example for a MySQL database using ruby1.8 or jruby:

production:
  adapter: mysql2      (note: For Rails < 3.1 use mysql instead of mysql2)
  database: redmine
  host: localhost
  username: redmine
  password: my_password

Open a mysql command prompt:

mysql -u root -p
"

echo "^C to break, anykey to contiue...."; read readline

mysql -u root -p

echo "At the mysql prompt enter the mysql commands:

create user 'redmine' identified by 'redmine';
set password for 'redmine'@'localhost' = password('my_password');
grant all on *.* to 'redmine'@'localhost';
create database redmine;
quit;

Configuration

Copy config/database.yml.example to config/database.yml and edit this file in order to configure your database settings for \"production\" environment.
Example for a MySQL database using ruby1.8 or jruby:

production:
  adapter: mysql2      (note: For Rails < 3.1 use mysql instead of mysql2)
  database: redmine
  host: localhost
  username: redmine
  password: my_password


Generate a session store secret:
"

echo "^C to break, anykey to contiue...."; read readline

echo "rake generate_secret_token

Generate the database structure:

RAILS_ENV=production rake db:migrate

Generate default configuration data:

RAILS_ENV=production rake redmine:load_default_data


(using “es” for Spanish language in terminal prompt)

Setup config file in config/configuration.yml

Change database_ciphr_key: *

rake db:encrypt RAILS_ENV=production

Apache

Setup Apache’s VirtualHost config

# 8080 in this case is because we use a reverse proxy before Apache. Otherwise simply use \"*:80\" 
read readline
echo "
<VirtualHost *:8080>
 ServerName redmine.example.com
 DocumentRoot /usr/local/share/redmine/public
 <Directory /usr/local/share/redmine/public>
   AllowOverride all
   Options -MultiViews
 </Directory>
</VirtualHost>

Once you enable this virtual host (a2ensite redmine.example.com) and reload Apache (apache2ctl graceful), you should see your site running on http://redmine.example.com.

The default login/password is admin/admin (don't forget to change this).
Sources of inspiration

We used the following resources as a starting point. Thanks to their respective authors.

    http://madpropellerhead.com/random/20100820-installing-redmine-on-debian-with-apache (outdated, for Lenny)
    http://www.redmine.org/projects/redmine/wiki/RedmineInstall
    http://hodza.net/2012/03/15/howto-install-redmine-on-debian-6-squeeze-ruby-on-rails-apache2-passenger/
    http://www.redmine.org/projects/redmine/wiki/HowTo_Install_Redmine_on_Debian_with_Ruby-on-Rails_and_Apache2-Passenger

Powered by Redmine © 2006-2013 Jean-Philippe Lang
"


echo "^ to break, anykey to contiue...."; read readline




