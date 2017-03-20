
sudo apt-get install redmine redmine-mysql

sudo  apt-get update

sudo  apt-get upgrade 
sudo dpkg --configure -a

sudo apt-get install -y  --force-yes  apache2
sudo apt-get install -y  --force-yes  apache2-threaded-dev
sudo apt-get install -y  --force-yes  build-essential
sudo apt-get install -y  --force-yes  libapache-dbi-perl
sudo apt-get install -y  --force-yes  libapache2-mod-perl2
sudo apt-get install -y  --force-yes  libapache2-svn
sudo apt-get install -y  --force-yes  libdigest-sha1-perl
sudo apt-get install -y  --force-yes  libgemplugin-ruby
sudo apt-get install -y  --force-yes  libgemplugin-ruby1.8
sudo apt-get install -y  --force-yes  libruby-extras
sudo apt-get install -y  --force-yes  libruby1.8-extras
sudo apt-get install -y  --force-yes  mongrel
sudo apt-get install -y  --force-yes  mysql-server
sudo apt-get install -y  --force-yes  rails
sudo apt-get install -y  --force-yes  rake
sudo apt-get install -y  --force-yes  ruby
sudo apt-get install -y  --force-yes  rubygems
sudo apt-get install -y  --force-yes  rubygems1.8
sudo apt-get install -y  --force-yes  ruby1.8-dev
sudo apt-get install -y  --force-yes  ruby-dev
sudo apt-get install -y  --force-yes  subversion

sudo apt-get install -y  --force-yes  mercurial
sudo apt-get install -y  --force-yes  cvs
sudo apt-get install -y  --force-yes  darcs


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
    address: "smtp.gmail.com"
    port: '587'
    domain: "smtp.gmail.com"
    authentication: :plain
    user_name: "bayvictor@gmail.com"
    password: "jing214202"

development:
  delivery_method: :smtp
  smtp_settings:
    tls: true
    address: "smtp.gmail.com"
    port: '587'
    domain: "smtp.gmail.com"
    authentication: :plain
    user_name: "bayvictor@gmail.com"
    password: "jing214202"

test:
  delivery_method: :test

" >>  /etc/redmine/default/email.yml



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




apache_restart.sh





