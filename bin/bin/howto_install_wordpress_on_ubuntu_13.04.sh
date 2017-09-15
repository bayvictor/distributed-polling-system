echo "How To Install WordPress On Ubuntu 13.04
Filed under: Solution Stuff — Leave a comment June 9, 2013
Open terminal (Ctrl+Alt+T) type command:
"
 sudo apt-get install wordpress
echo "The installation places the files in the /usr/share/wordpress folder. So that Apache2 knows where to find the installation folder, make a symbolic link to the Apache2 www folder:
"
sudo ln -s /usr/share/wordpress /var/www/wordpress 
echo "If mysql not installed type command otherwise ignore this step
"

sudo apt-get install mysql-server
echo "Then uncompress and install WordPress using the supplied script:
"

sudo gzip -d /usr/share/doc/wordpress/examples/setup-mysql.gz 
sudo bash /usr/share/doc/wordpress/examples/setup-mysql -n wordpress localhost

echo "This script creates the MySQL database and user wordpress for the new MySQL database named localhost (that will be used for WordPress).
"

sudo bash /usr/share/doc/wordpress/examples/setup-mysql -n wordpress_mydomain_org wordpress.mydomain.org
echo "Now restart apache2
"
sudo /etc/init.d/apache2 restart
echo "Lastly open link “http://localhost/wordpress“.
"


