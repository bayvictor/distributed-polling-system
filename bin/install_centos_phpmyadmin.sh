echo "run with root!"


echo "^C to break, anykey to contiue as root user..."; read readline


echo "First of all, are you sure php is installed properly?

If so, this is how I do it.

Log into your command line and make sure you're in as root.

Go to your web directory
"
 cd /var/www/html/
echo "
Grab it down to your server

# "
wget http://downloads.sourceforge.net/project/phpmyadmin/phpMyAdmin/4.0.2/phpMyAdmin-4.0.2-all-languages.tar.gz
echo "
Unarchive

#
"
tar -zxvf phpMyAdmin-4.0.2-all-languages.tar.gz

echo "You'll end up with a directory /var/www/html/phpMyAdmin-4.0.2-all-languages so rename it

# "
mv phpMyAdmin-4.0.2-all-languages phpMyAdmin

echo "Then change the permissions so Apache can execute.

# "
chmod -R 755 phpMyAdmin

echo "Change directory and create a config file

# "
cd phpMyadmin

 mv config.sample.inc.php config.inc.php

echo "Go in and edit anything if you need to, you probably won't.

Now you can go to http:///phpMyAdmin/index.php and log in.
"

echo "^C to break, anykey to contiue as root user..."; read readline
echo "If you are unable to log in, you might want to check if your php sessions are working OK. Check the php.ini file for session.save_path and make sure that path is writeable.

You can change your language on the login screen.
Gravatar
Answered by Gavin Chapman
"



