echo "2. Copy/Paste the following line of code into Terminal and then press enter:

sudo  yum  -y install apache2
"
read readline
sudo  yum  -y install apache2

echo "3. The Terminal will then ask you for you're password, type it and then press enter.

 
Testing Apache

To make sure everything installed correctly we will now test Apache to ensure it is working properly.

1. Open up any web browser and then enter the following into the web address:

http://localhost/


You should see a folder entitled apache2-default/. Open it and you will see a message saying \"It works!\" , congrats to you!
"
read readline
 
echo "Install PHP

In this part we will install PHP 5.

Step 1. Again open up the Terminal (Applications > Accessories > Terminal).

Step 2. Copy/Paste the following line into Terminal and press enter:

sudo  yum  -y install php5 libapache2-mod-php5
"
sudo  yum  -y install php5 libapache2-mod-php5
read readline

echo "Step 3. In order for PHP to work and be compatible with Apache we must restart it. Type the following code in Terminal to do this:

sudo /etc/init.d/apache2 restart
"
read readline

sudo /etc/init.d/apache2 restart
 
echo "Test PHP

To ensure there are no issues with PHP let\'s give it a quick test run.

Step 1. In the terminal copy/paste the following line:
sudo gedit /var/www/testphp.php
This will open up a file called phptest.php.
"
read readline

sudo gedit /var/www/testphp.php



echo "Step 2. Copy/Paste this line into the phptest file:

<?php phpinfo(); ?>

Step 3. Save and close the file.

Step 4. Now open you\'re web browser and type the following into the web address:

http://localhost/testphp.php
"
read readline

echo "The page should look like this:

Test PHP Page

Congrats you have now installed both Apache and PHP!

 
Install MySQL

To finish this guide up we will install MySQL. (Note - Out of Apache and PHP, MySQL is the most difficult to set up. I will provide some great resources for anyone having trouble at the end of this guide.)

Step 1. Once again open up the amazing Terminal and then copy/paste this line:

sudo  yum  -y install mysql-server
"
read readline
sudo  yum  -y install mysql-server
echo "Step 2 (optional). In order for other computers on your network to view the server you have created, you must first edit the \"Bind Address\". Begin by opening up Terminal to edit the my.cnf file.

gksudo gedit /etc/mysql/my.cnf

Change the line

bind-address = 127.0.0.1

And change the 127.0.0.1 to your IP address.
"
read readline

echo "Step 3. This is where things may start to get tricky. Begin by typing the following into Terminal:

mysql -u root

Following that copy/paste this line:

mysql> SET PASSWORD FOR \'root\'@\'localhost\' = PASSWORD(\'yourpassword\');

(Make sure to change yourpassword to a password of your choice.)
"
read readline

echo "Step 4. We are now going to install a program called phpMyAdmin which is an easy tool to edit your databases. Copy/paste the following line into Terminal:

sudo  yum  -y install libapache2-mod-auth-mysql php5-mysql phpmyadmin

After that is installed our next task is to get PHP to work with MySQL. To do this we will need to open a file entitled php.ini. To open it type the following:
"
sudo  yum  -y install libapache2-mod-auth-mysql php5-mysql phpmyadmin
read readline
echo "
gksudo gedit /etc/php5/apache2/php.ini
"
read readline

gksudo gedit /etc/php5/apache2/php.ini
echo "Now we are going to have to uncomment the following line by taking out the semicolon (;).

Change this line:

;extension=mysql.so

To look like this:

extension=mysql.so

Now just restart Apache and you are all set!


sudo /etc/init.d/apache2 restart
 
The End

Quick note to anyone who encountered problems with setting up the MySQL password, please refer to this page: MysqlPasswordReset

I applaud everyone who has taken the time to read this guide. This guide is also my first ever so I would love to hear back from the public on what you guys think! Just don't be too harsh. ;)

If you have questions about installing any part of LAMP just drop them in the comment box and I will do my best to help you out."

sudo /etc/init.d/apache2 restart
read readline
 
sudo yum install phpmyadmin -y 

