sudo gem update 
sudo apt-get install -y redmine redmine-mysql

sudo dpkg --configure -a

sudo apt-get install -y   apache2
sudo apt-get install -y   apache2-threaded-dev
sudo apt-get install -y   build-essential
sudo apt-get install -y   libapache-dbi-perl
sudo apt-get install -y   libapache2-mod-perl2
sudo apt-get install -y   libapache2-svn
sudo apt-get install -y   libdigest-sha1-perl
sudo apt-get install -y   libgemplugin-ruby
sudo apt-get install -y   libgemplugin-ruby1.8
sudo apt-get install -y   libruby-extras
sudo apt-get install -y   libruby1.8-extras
sudo apt-get install -y   mongrel
sudo apt-get install -y   mysql-server
sudo apt-get install -y   rails
sudo apt-get install -y   rake
sudo apt-get install -y   ruby
sudo apt-get install -y   rubygems
sudo apt-get install -y   rubygems1.8
sudo apt-get install -y   ruby1.8-dev
sudo apt-get install -y   ruby-dev
sudo apt-get install -y   subversion

sudo apt-get install -y   mercurial
sudo apt-get install -y   cvs
sudo apt-get install -y   darcs


sudo ln -s /usr/share/redmine/public /var/www/redmine

sudo chown www-data:www-data /var/www/redmine -R

#


echo "^C to break from reconfiguration, any key to continue..."


read readline 
echo "<IfModule mod_passenger.c>
  PassengerRoot /usr/lib/ruby/gems/1.8/gems/passenger-3.0.9
  PassengerRuby /usr/bin/ruby1.8
  PassengerDefaultUser www-data

</IfModule>

" >> /etc/apache2/mods-available/passenger.conf

gedit  /etc/apache2/mods-available/passenger.conf &

echo "
<Directory /var/www/redmine>
RailsBaseURI /redmine
PassengerResolveSymlinksInDocumentRoot on
</Directory>
" >> /etc/apache2/sites-enabled/000-default

gedit /etc/apache2/sites-enabled/000-default &

echo "
# File: config/email.yml
production:
  delivery_method: :smtp
  smtp_settings:
    tls: true
    address: 'smtp.gmail.com'
    port: '587'
    domain: 'smtp.gmail.com'
    authentication: :plain
    user_name: 'bayvictor@gmail.com'
    password: 'jing214202'

development:
  delivery_method: :smtp
  smtp_settings:
    tls: true
    address: 'smtp.gmail.com'
    port: '587'
    domain: 'smtp.gmail.com'
    authentication: :plain
    user_name: 'bayvictor@gmail.com'
    password: 'jing214202'

test:
  delivery_method: :test

" >>  /etc/redmine/default/email.yml
# ""


echo "If you set your AppArmor mysqld profile to complain you ought to set it back to enforce:

    $ "
sudo aa-enforce /usr/sbin/mysqld

echo "Enable passenger:

    $ "
sudo a2enmod passenger

echo "Restart apache2

    $ "
sudo chmod a+x /usr/share/redmine/public

sudo service apache2 restart

echo "and you should be able to access Redmine at: http://redmine.server.ip.address/redmine
"

read readline

echo "If you receive a \"403: Forbidden\" error after setting up Redmine, the Redmine 'public' folder may have incorrect permissions set. The executable bit on the public folder must be enabled or you will receive a \"403: Forbidden\" error when attempting to access Redmine.

    $ sudo chmod a+x /usr/share/redmine/public
"

sudo  apt-get update
sudo  apt-get upgrade 



apache_restart.sh





