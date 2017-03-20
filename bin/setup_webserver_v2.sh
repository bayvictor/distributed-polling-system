echo "From source:

Arie was so nice to make a quick installation manual for Ubuntu 7.10,
which should be similar for newer versions as well. With a bit of tweaking these are the steps:

Installing the web server, database server, and script processor:

#"
 sudo apt-get update
 sudo apt-get upgrade
 sudo apt-get install apache2 php5 mysql-server procps
 sudo apt-get install php5-cli php5-mysql php5-xmlrpc php5-curl php5-gmp
 sudo apt-get install yydecode unrar par2 trickle smarty coreutils

echo "In case  yydecode isn't in your repository anymore (since Ubuntu 11.10), you can use this option to obtain it from getdeb

add line to /etc/apt/sources.list
deb http://archive.getdeb.net/ubuntu/ precise-getdeb apps

# wget -q -O- http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -

 

And optionally but recommended:

# "
sudo apt-get install arj p7zip-full unace-nonfree trickle unzip tar
 sudo apt-get install p7zip, cfv

echo "Restart Apache:
"
 /etc/init.d/apache2 restart
