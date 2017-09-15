apt-get install -y libapache2-mod-perl2-dev
/usr/bin/perl install-module.pl --all
perl -MCPAN -e 'install Bundle::Bugzilla'


echo "    Bugzilla

Translation(s): English - 简体中文
	

(!) Discussion

Prior to installation of bugzilla, a CGI capable webserver package should be installed, together with the [mysql-client] packages. If a remote [mysql-server] is not being used, it is also necessary to install the [mysql-server] package.

Installation

Installation of the web server

It is assumed the the [thttpd] web server package is being used for bugzilla.
"
read readline
    apt-get install thttpd 

echo "Installation of the mysql server daemon
"
    apt-get install mysql-server 

echo "Installation of the mysql client
"
    apt-get install mysql-client 

echo "Configure the password for the mysql root user

It is necessary to configure a password for the mysql root user. The default blank password cannot be used. To setup the mysql root password for first time, use mysqladmin command at shell prompt as follows:
"
read readline
    mysqladmin -u root password vhuang  #NEWPASSWORD 

echo "Installation of the bugzilla package

Install the bugzilla package.
"

    apt-get install bugzilla3 

echo "Configure database for bugzilla with dbconfig-common

The bugzilla package must have a database installed and configured before it can be used. If this is a first time installation and the database has not been installed or configured, this option will configure a common database.

Configure database for bugzilla with dbconfig-common? y

What is the password for the administrative account with which this package should create its mysql database and user?

Password of your database's administrative user:

Troubleshooting

Errors during installation

ERROR 1045 (28000): Access denied for user 'root'@'localhost' (using password: YES)

This error occurs if the mysql root password has not been set, or the password being entered at the dbconfig-common password prompt does not match that of the mysql root user.

Resolution

Configure the password for the mysql root user

mysql said: ERROR 1049 (42000): Unknown database 'bugzilla'

There is a bug in the bugzilla configure script, which causes an Unknown database error if the bugzilla database does not exist.
"
read readline

echo "Resolution

To resolve this error, it is necessary to create an empty bugzilla database:

First login to mysql:
"
    mysql -u root -p 

echo "Create the bugzilla database:

    create database bugzilla; quit; 

Bugzilla (last edited 2011-09-25 06:19:21 by DebiNix)

    MoinMoin Powered
    Python Powered
    Valid HTML 4.01
    Debian Wiki team, bugs and config available.
    Hosting provided by Dembach Goo Informatik GmbH & Co KG


"
read readline
