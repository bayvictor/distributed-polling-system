echo "Run it as root! ^C to break"
read readline
echo "Installing and configuring Trac and Subversion on squeeze
Share on googleShare on facebookShare on twitterShare on emailMore Sharing Services

TracTrac is an enhanced wiki and issue tracking system for software development projects. Trac uses a minimalistic approach to web-based software project management.

Trac allows wiki markup in issue descriptions and commit messages, creating links and seamless references between bugs, tasks, changesets, files and wiki pages. A timeline shows all current and past project events in order, making the acquisition of an overview of the project and tracking progress very easy. The roadmap shows the road ahead, listing the upcoming milestones.

Install and configure Trac and subversion

1. Install required packages for both Trac and Subversion. We'll be using Apache to publish the Subversion repositories
"
sudo apt-get install -y python-setuptools trac subversion libapache2-svn libapache2-mod-python 
sudo apt-get install -y a2enmod 
sudo apt-get install -y dav_fs

echo "2. Create a template SVN repository which we will copy later to create new repositories.
"

mkdir /var/svn/
mkdir /var/svn/tmpproject
mkdir /var/svn/tmpproject/branches
mkdir /var/svn/tmpproject/tags
mkdir /var/svn/tmpproject/trunk

echo "3. Enable the Apache SVN module
"

a2enmod dav_fs

echo "4. Create a password file containing users that have access to the Subversion repositories and Trac
"
htpasswd -c /etc/apache2/svn.passwd bsquare2
sudo htpasswd -mc /etc/apache2/svn.passwd $USER

htpasswd -c /etc/apache2/svn.passwd vhuang
htpasswd /etc/apache2/svn.passwd greg

echo "5. Edit the apache configurations to enable Trac and Subversion SVN (pico /etc/apache2/sites-enabled/000-default). Add the following lines:

<Location /svn>
DAV svn
SVNParentPath /var/svn
SVNAutoversioning on
AuthType Basic
AuthName "Subversion Repository"
AuthUserFile /etc/apache2/svn.passwd
Require valid-user
</Location>
<Location "/trac">
SetHandler mod_python
PythonHandler trac.web.modpython_frontend
PythonOption TracEnvParentDir /var/trac/
PythonOption TracUriRoot /trac
AuthType Basic
AuthName "Trac"
AuthUserFile /etc/apache2/svn.passwd
Require valid-user
</Location>

6. Create a directory for Trac projects
"

mkdir /var/trac

echo "Create the first project

1. Create a subversion repository and import the directory structure from the tmpproject template

svnadmin create /var/svn/myproject --fs-type fsfs
svn import /var/svn/tmpproject file:///var/svn/myproject -m "initial import"
find /var/svn/myproject -type f -exec chmod 660 {} \;
find /var/svn/myproject -type d -exec chmod 2770 {} \;
chown -R root.www-data /var/svn/myproject

2. Create the Trac project

trac-admin /var/trac/myproject initenv
find /var/trac/myproject -type f -exec chmod 660 {} \;
find /var/trac/myproject -type d -exec chmod 2770 {} \;
chown -R root.www-data /var/trac/myproject

3. Restart Apache

/etc/init.d/apache2 restart

4. Give a user administrator permissions to the project

trac-admin /var/trac/myproject
permission add user1 TRAC_ADMIN

You can now access your Trac project by browsing with your favorite browser to http://localhost/trac/myproject.

To access the Subversion reposatory you can use any Subversion client. If you're using Windows, TortoiseSVN would be a good choice. The location to the new SVN repository is something like this: http://localhost/svn/myproject
Tagged as: apache, python, Squeeze, svn, trac
"
