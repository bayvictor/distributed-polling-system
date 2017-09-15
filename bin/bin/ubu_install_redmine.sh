echo "Step-by-step for Ubuntu 12.04
A step-by-step guide to getting Redmine running on a fresh installation of Ubuntu.

Ubuntu 10.04 or 12.04 using Passenger
The installation assumes that the web server and database are already in place, so you probably want to install the LAMP stack first if you don't already have it:

$ "
read readline
sudo tasksel install lamp-server

echo "You will also need to install the Passenger apache module.

$ "
sudo apt-get install libapache2-mod-passenger

echo "Also, the default AppArmor configuration can get in the way, so you may need to set the mysqld profile to complain:

$ "
sudo aa-complain /usr/sbin/mysqld

echo "Installing Redmine 0.9.3 (Ubuntu 10.04) or Redmine 1.3.2 (Ubuntu 12.04)
As of 10.04 and 12.04, Redmine is available through Ubuntu's package manager, and installation is simple:

$ "
sudo apt-get install redmine redmine-mysql

echo "^C to break, anykey to use ppa to install latest version of redmine!"
read readline

echo "The second package, redmine-mysql, can be replaced by either redmine-pgsql or redmine-sqlite if you want to use either of those databases.

The installation process should prompt you for all the interesting details.

Redmine will now be installed in /usr/share/redmine and /etc/redmine

Installing the latest Redmine
The package with Ubuntu 10.04 is stuck in the 0.9.x branch and Ubuntu 12.04 is stuck in the 1.3.x branch. A PPA exists that has the latest branch here: https://launchpad.net/~ondrej/+archive/redmine

To install redmine using the PPA:

$ sudo add-apt-repository ppa:ondrej/redmine
$ sudo apt-get update
$ sudo apt-get install redmine redmine-mysql

Note: If your server is behind a firewall, you will need to export your firewall settings before running add-apt-repository. Otherwise, the command will hang.
Run the following
"
read readline

export http_proxy="http://proxy.your.server:port" and export https_proxy="http:proxy.your.server:port".
Configuration
Symlink /usr/share/redmine/public to your desired web-accessible location. E.g.:

$ sudo ln -s /usr/share/redmine/public /var/www/redmine

By default, passenger runs as 'nobody', so you'll need to fix that. In /etc/apache2/mods-available/passenger.conf, add:

PassengerDefaultUser www-data
You'll also need to configure the /var/www/redmine location in /etc/apache2/sites-available/default by adding:

<Directory /var/www/redmine>
RailsBaseURI /redmine
PassengerResolveSymlinksInDocumentRoot on
</Directory>
If you set your AppArmor mysqld profile to complain you ought to set it back to enforce:

$ sudo aa-enforce /usr/sbin/mysqld

Enable passenger:

$ sudo a2enmod passenger

Restart apache2

$ sudo service apache2 restart

and you should be able to access Redmine at: http://redmine.server.ip.address/redmine

If you receive a "403: Forbidden" error after setting up Redmine, the Redmine 'public' folder may have incorrect permissions set. The executable bit on the public folder must be enabled or you will receive a "403: Forbidden" error when attempting to access Redmine.

$ sudo chmod a+x /usr/share/redmine/public

Ubuntu 10.04 or 12.04 using WEBrick
Using Passenger is recommended for the heavy load server. But WEBrick uses less memory.

Install Redmine: (See also Installing the latest Redmine above)

$ sudo apt-get install redmine redmine-mysql

Then, create this for /etc/init/redmine.conf

# Redmine

description "Redmine" 

start on runlevel [2345]
stop on runlevel [!2345]

expect daemon
exec ruby /usr/share/redmine/script/server webrick -e production -b 0.0.0.0 -d
You can start Redmine by this. You can access by http://example.com:3000/

$ sudo service redmine start

You can stop by this.

$ sudo service redmine stop

Ubuntu 10.04 using mod_cgi
The installation assumes that the web server and database are already in place, so you probably want to install the LAMP stack first if you don't already have it:

$ sudo tasksel install lamp-server

Also, the default AppArmor configuration can get in the way, so you may need to set the mysqld profile to complain:

$ sudo aa-complain /usr/sbin/mysqld

As of 10.04, Redmine is available through Ubuntu's package manager, and installation is simple:

$ sudo apt-get install redmine redmine-mysql subversion

The second package, redmine-mysql, can be replaced by either redmine-pgsql or redmine-sqlite if you want to use either of those databases.

The installation process should prompt you for all the interesting details.

Redmine will now be installed in /usr/share/redmine and /etc/redmine

If you set your AppArmor mysqld profile to complain you ought to set it back to enforce:

$ sudo aa-enforce /usr/sbin/mysqld

Configuration
Using Ubuntu Server 10.04.1, configuring Redmine via mod_cgi as described in this section does not seem to work. If you can successfully make this work, please update these instructions! Otherwise follow the instructions in the next section for installing on Ubuntu 10.04 using Passenger or WEBrick if mod_cgi does not work for you.

Symlink /usr/share/redmine/public to your desired web-accessible location. E.g.:

$ sudo ln -s /usr/share/redmine/public /var/www/redmine

Also symlink /var/cache/redmine/default/plugin_assets to your redmine directory. E.g.:

$ sudo ln -s /var/cache/redmine/default/plugin_assets /usr/share/redmine/public/

This will ensure that any graphics or other resources are displayed in any installed add-ons.

The other files that you need to modify/create are as follows:

/etc/redmine/default/database.yml:

production:
adapter: mysql
database: redmine
host: localhost
username: redmine
password: pa55w0rd
encoding: utf8
/usr/share/redmine/public/dispatch.cgi:

#!/usr/bin/ruby

require File.dirname(__FILE__) + "/../config/environment" unless defined?(RAILS_ROOT)

require "dispatcher" 

ADDITIONAL_LOAD_PATHS.reverse.each { |dir| $:.unshift(dir) if File.directory?(dir) } if defined?(Apache::RubyRun)
Dispatcher.dispatch
/usr/share/redmine/public/.htaccess:

RewriteEngine On
RewriteBase /redmine
RewriteRule ^$ index.html [QSA]
RewriteRule ^([^.]+)$ $1.html [QSA]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteRule ^(.*)$ dispatch.cgi [QSA,L]
And that's it! If these instructions didn't work for you, please expand them to include whatever is needed.


