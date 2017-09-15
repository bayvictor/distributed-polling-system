
export CURPATH=$PWD  #
#
sudo apt-get install -y libgdl-3-dev #- GNOME DevTool libraries #- development files
sudo apt-get install -y libgd-gd2-perl #- Perl module wrapper for libgd #- gd2 variant

cd ~/src/Django-1.4

sudo python setup.py install


sudo apt-get install -y git-core gnupg  default-jdk flex bison gperf libsdl-dev libesd0-dev libwxgtk2.6-dev build-essential zip curl libncurses5-dev zlib1g-dev
 sudo apt-get install -y python-pip python-dev build-essential 
sudo apt-get install python-setuptools python-dev build-essential 
sudo /usr/bin/apt-get install -y build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion
 sudo apt-get install -y python-pip python-dev build-essential 
sudo apt-get install python-setuptools python-dev build-essential 
      sudo apt-get install -y linux-headers-`uname -r` build-essential xinetd
    sudo apt-get install -y build-essential perl python git
Build essentials on Ubuntu/Debian:
    sudo apt-get install -y build-essential perl python git
    sudo apt-get install -y build-essential perl python git
sudo apt-get install -y git-core gnupg flex bison gperf build-essential zip curl  default-jdk zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev  lib32ncurses5 lib32z1 x11proto-core-dev libx11-dev lib32readline5-dev lib32z-dev
sudo apt-get install -y build-essentials
sudo apt-get install -y git-core gnupg flex bison gperf build-essential zip curl  default-jdk zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev  lib32ncurses5 lib32z1 x11proto-core-dev libx11-dev lib32readline5-dev lib32z-dev
sudo apt-get install -y linux-headers-`uname -r` build-essential xinetd
apt-get install g++ rpm zlib1g-dev m4 bison libncurses5-dev gettext build-essential intltool libxml2-dev libtool


 sudo apt-get install -y mysql-server
sudo apt-get install -y mysql-client 
sudo apt-get install -y mysql-common
sudo apt-get install -y libapache2-mod-wsgi
sudo apt-get -y install php5 libapache2-mod-php5
sudo apt-get -y install libapache2-mod-auth-mysql php5-mysql phpmyadmin

sudo apt-get install -y libimvirt-perl #- Perl module for detecting several virtualizations
apt-get install -y libapache2-mod-perl2-dev


perl -MCPAN -e 'install Bundle::Bugzilla'

/usr/bin/perl install-module.pl --all



#cd wget http://ftp.mozilla.org/pub/mozilla.org/webtools/
cd $CURPATH

cd bugzilla-3.6.11
/usr/bin/perl install-module.pl --all


./checksetup.pl

#perl -MCPAN -e shell  #

echo 'cpan>   install  "Bundle::Bugzilla"   '

cd ..
cd bugzilla-4*
 /usr/bin/perl install-module.pl --all

./checksetup.pl

grpadd www-data
useradd www-data
passwd www-data
cp ~/src/bugzilla_3_4/bugzilla-3.6.11 /var/www/bugzilla3 -fr
cp ~/src/bugzilla_3_4/bugzilla-4.2.1 /var/www/bugzilla4 -fr
chown www-data:www-data /var/www -R

echo "try on browser to test:"
echo "http://127.0.0.1/bugzilla3"
echo ""http://127.0.0.1/bugzilla4

firefox   http://127.0.0.1/bugzilla4 &

echo "^C to break, any key to add bugzilla3 bugzilla4 lines into httpd.conf"

echo " After press return, in httpd.conf search </VirtualHost> line and move it to the very end"
read readline


echo "
<Directory /var/www/bugzilla3>
  AddHandler cgi-script .cgi .pl
  #Options +Indexes +ExecCGI
  Options +Indexes +ExecCGI +FollowSymLinks 
  DirectoryIndex index.cgi
  AllowOverride all
#  AllowOverride Limit
</Directory>
 

<Directory /var/www/bugzilla4>
  AddHandler cgi-script .cgi .pl
  #Options +Indexes +ExecCGI
  Options +Indexes +ExecCGI +FollowSymLinks 
  DirectoryIndex index.cgi
  AllowOverride all
#  AllowOverride Limit
</Directory>
 " >>  /etc/apache2/sites-enabled/000-default


gedit   /etc/apache2/sites-enabled/000-default &   
 

cd /var/www/bugzilla3
./checksetup.pl
  /usr/bin/perl install-module.pl --all

cd /var/www/bugzilla4   #a
./checksetup.pl
  /usr/bin/perl install-module.pl --all



 
