echo "Step 1. Install LAMP server on ubuntu server, to install -y --force-yes  LAMP Server in Ubuntu server 12.04 you can follow instructions @LAMP Ubuntu Server 12.04 LTS
Step 2. If you do not have a problem when install -y --force-yes ing lamp server in ubuntu server 12.04, we proceed to install -y --force-yes  wordpress
"
sudo apt-get install -y --force-yes  wordpress

echo "Step 3. Make a symbolic link to the Apache2 directory /var/www/ , The wordpress install -y --force-yes ation placed in directory /usr/share/wordpress folder
"

echo "Control-C to break, anykey to continue...";read readline
sudo ln -s /usr/share/wordpress /var/www/wordpress

echo "Step 4. install -y --force-yes  WordPress with the supplied script, the script placed in directory /usr/share/doc/wordpress/examples/. 
"

echo "Control-C to break, anykey to continue...";read readline
sudo bash /usr/share/doc/wordpress/examples/setup-mysql -n wordpress localhost

echo "After execute this script, it will creates the MySQL database and user wordpress for the new MySQL database named localhost. If you have install -y --force-yes ed virtual host on server and/or already know your URL, it is best to name your database the same as your URL. Also if you plan on hosting multiple blogs with different virtual hosts, each needs a differently named database.
"

echo "Control-C to break, anykey to continue...";read readline
sudo bash /usr/share/doc/wordpress/examples/setup-mysql -n wordpress_preciseserver blog.preciseserver.com

echo "Step 5. For automatic updates to occur, the folder and all its files and subfolders wordpress must be owned by www-data:
"

echo "Control-C to break, anykey to continue...";read readline
chown -R www-data:www-data /usr/share/wordpress

echo "Now, open your web browser to install -y --force-yes  wordpress, type on address bar http://localhost/wordpress
"


echo "Control-C to break, anykey to continue...";read readline
