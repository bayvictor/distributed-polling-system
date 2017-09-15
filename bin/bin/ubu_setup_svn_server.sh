echo "How to setup a Subversion (SVN) server on GNU/Linux - Ubuntu
"
echo "I have a laptop running Ubuntu that I would like to act as a Subversion server. Both for myself to commit to locally, and for others remotely. What are the steps required to get this working? Please include steps to:

get and configure Apache, and necessary modules (I know there are other ways to create a SVN server, but I would like it Apache-specific)
configure a secure way of accessing the server (ssh/https)
configure a set of authorised users (as in, they must authorised to commit, but are free to browse)
validate the setup with an initial commit (a "Hello world" of sorts)
These steps can involve any mixture of command line or GUI app instructions. If you can, please note where instructions are specific to a particular distribution or version, and where a users' choice of a particular tool can be used instead (say, nano instead of vi).

linux svn ubuntu debian
share|improve this question
edited Sep 16 '08 at 3:53

Bernard
8,93383454	
asked Sep 13 '08 at 18:00

Grundlefleck
20.5k124172
6 Answers activeoldestvotes
up vote
82
down vote
accepted
Steps I've taken to make my laptop a Subversion server. Credit must go to AlephZarro for his directions here. I now have a working SVN server (which has currently only been tested locally).

Specific setup: Kubuntu 8.04 Hardy Heron

Requirements to follow this guide:

apt-get package manager program
text editor (I use kate)
sudo access rights
1: Install Apache HTTP server and required modules:
"
sudo apt-get install libapache2-svn apache2
echo "The following extra packages will be installed:
"
apache2-mpm-worker apache2-utils apache2.2-common
echo "2: Enable SSL
"
sudo a2enmod ssl
sudo kate /etc/apache2/ports.conf
echo "Add or check that the following is in the file:
<IfModule mod_ssl.c>
    Listen 443
</IfModule>

3: Generate an SSL certificate:
"
sudo echo "
<IfModule mod_ssl.c>
    Listen 443
</IfModule>

">>/etc/apache2/ports.conf

sudo apt-get install ssl-cert
sudo mkdir /etc/apache2/ssl
sudo /usr/sbin/make-ssl-cert /usr/share/ssl-cert/ssleay.cnf /etc/apache2/ssl/apache.pem
echo "
4: Create virtual host
"
sudo cp /etc/apache2/sites-available/default /etc/apache2/sites-available/svnserver

sudo cat  /etc/apache2/sites-available/svnserver/ports.conf | sed 's|NameVirtualHost \*|NameVirtualHost \*:443|g' | sed 's|<VirtualHost *>|<VirtualHost *:443>|g' |grep 443 
Change (in ports.conf):

"NameVirtualHost *" to "NameVirtualHost *:443"
and (in svnserver)

<VirtualHost *> to <VirtualHost *:443>
Add, under ServerAdmin (also in file svnserver):

SSLEngine on
SSLCertificateFile /etc/apache2/ssl/apache.pem
SSLProtocol all
SSLCipherSuite HIGH:MEDIUM
5: Enable the site:

sudo a2ensite svnserver
sudo /etc/init.d/apache2 restart
To overcome warnings:

sudo kate /etc/apache2/apache2.conf
Add:

"ServerName $your_server_name"
6: Adding repository(ies): The following setup assumes we want to host multiple repositories. Run this for creating the first repository:

sudo mkdir /var/svn

REPOS=myFirstRepo
sudo svnadmin create /var/svn/$REPOS
sudo chown -R www-data:www-data /var/svn/$REPOS
sudo chmod -R g+ws /var/svn/$REPOS
6.a. For more repositories: do step 6 again (changing the value of REPOS), skipping the step mkdir /var/svn

7: Add an authenticated user

sudo htpasswd -c -m /etc/apache2/dav_svn.passwd $user_name
8: Enable and configure WebDAV and SVN:

sudo kate /etc/apache2/mods-available/dav_svn.conf
Add or uncomment:

<Location /svn>
DAV svn

# for multiple repositories - see comments in file
SVNParentPath /var/svn

AuthType Basic
AuthName "Subversion Repository"
AuthUserFile /etc/apache2/dav_svn.passwd
Require valid-user
SSLRequireSSL
</Location>
9: Restart apache server:

sudo /etc/init.d/apache2 restart
10: Validation:

Fired up a browser:

http://localhost/svn/$REPOS
https://localhost/svn/$REPOS
Both required a username and password. I think uncommenting:

<LimitExcept GET PROPFIND OPTIONS REPORT>

</LimitExcept>
in /etc/apache2/mods-available/dav_svn.conf, would allow anonymous browsing.

The browser shows "Revision 0: /"

Commit something:

svn import --username $user_name anyfile.txt https://localhost/svn/$REPOS/anyfile.txt -m “Testing”
Accept the certificate and enter password. Check out what you've just committed:

svn co --username $user_name https://localhost/svn/$REPOS
Following these steps (assuming I haven't made any error copy/pasting), I had a working SVN repository on my laptop.

share|improve this answer
edited Mar 8 at 1:58

Cristi Diaconescu
6,028432104	
answered Sep 13 '08 at 19:37

Grundlefleck
20.5k124172
Instructions worked perfectly on Jaunty as well. Thanks! – Michael Moussa Nov 28 '09 at 4:41
4	  
Seemed to work perfectly, but I get a 403 forbidden when trying to access it, and no prompt for a password. Any hints on what could be wrong? – korona Jun 30 '10 at 12:16
@korona: Accessing it in what way: running SVN commands or browsing to it? – Grundlefleck Jul 4 '10 at 21:06
In steps 3 and 4 aren't you repeating the line: sudo cp /etc/apache2/sites-available/default /etc/apache2/sites-available/svnserver ? – Megacan Sep 7 '10 at 10:19
1	  
"NameVirtualHost *" to "NameVirtualHost *:443" is in the ports.conf while <VirtualHost *> to <VirtualHost *:443> is in the svnserver settings. this should be mentioned. i got pretty confused because i searched in the svnserver settings for NameVirtualHost and could not find it. – Wandang Aug 14 '12 at 8:50
show 9 more comments

up vote
1
down vote
This article seems to give a pretty good rundown of the entire process. I would recommend following the instructions, and then posting some more specific questions about any problems you encouter which aren't addressed in the articles I and other people have linked to in these responses.

share|improve this answer
answered Sep 13 '08 at 18:11

Kibbee
32.5k1589138
up vote
1
down vote
A very easy way to get a SVN server up is to use the site Assembla.

They provide tons of free services, including SVN hosting.

share|improve this answer
answered Sep 16 '08 at 3:54

jjnguy♦
51.8k19138217
up vote
0
down vote
If you get 403 forbidden when you hit the webserver it may be because you used a hostname that is not what you specified in your config file (ie localhost or 127.0.0.1). Try hitting https://whateveryousetasyourhostname instead...

share|improve this answer
answered Jul 25 '10 at 11:49

PuO2
11
Another 403 cause: set svn path to a symlink. If your svn path is a symlink, you'll have to allow following symlinks. – copolii Nov 11 '11 at 10:26
up vote
0
down vote
Afterwards, I needed to execute (within the context of the example quoted above)

$ sudo chmod g+w /var/svn/$REPOS/db/rep-cache.db

$ sudo chown www-data:www-data /var/svn/$REPOS/db/rep-cache.db

Otherwise I kept receiving a 409 error when committing local modifications (though the commitments were server side effective, I needed to follow up with local updates)

share|improve this answer
answered Mar 4 '11 at 12:14

Thierry Marianne
749611
up vote
-2
down vote
for apache:

sudo apt-get -yq install apache2
for ssh

sudo apt-get -yq install openssh-server
for subversion

sudo apt-get -yq install subversion subversion-tools
If you'd like you can combine these into one command like:

sudo apt-get -yq install apache2 openssh-server subversion subversion-tools
I cant help with the rest...

share|improve this answer
edited Dec 28 '11 at 18:52

Community♦
1	
answered Sep 13 '08 at 18:09

UnkwnTech
18.6k26114171
Your Answer

 
Sign up or login

Sign up using Google
Sign up using Facebook
Sign up using Stack Exchange
Post as a guest

Name

Email

 
By posting your answer, you agree to the privacy policy and terms of service.

Not the answer you're looking for? Browse other questions tagged linux svn ubuntu debian or ask your own question.
tagged
linux × 56692
svn × 16579
ubuntu × 11204
debian × 2167
asked
4 years ago
viewed
104741 times
active
5 months ago
Community Bulletin
blogIntroducing Gabe, The Smiling Community Manager

Senior Game Programmer
Mind Pirate
Menlo Park, CA
Staff Software Engineer, Platform Infrastructure
Chegg
Santa Clara, CA
Senior Software Engineer - Cloud Connect
Steelwedge Software
Pleasanton, CA
More jobs near San Jose...
Linked
5 Beginner's Request for a Subversion Guide
-1 How to install SVN in Linux
2 SVN with Apache security
0 access svn server from other network
1 Problem setting up SVN & WebDAV in Ubuntu
1 Moving remote subversion server to a new local subversion server
0 Getting error 403 (forbidden) when trying to access newly setup svn directory (apache)
Related
114 Is there a Linux (Ubuntu) svn client that doesn't suck?
8 Where to find prebuilt binaries for subversion 1.6 for Ubuntu (or Debian)?
7 Visual SVN client for Debian Linux
0 Setup SVN/LAMP/Test Server/ on linux, where to start?
3 Subversion: Configure svn access through http protocol
2 How do I package Mono applications for Debian/Ubuntu
0 Configuring SVN repository in Amazon EC2 Ubuntu AMI
0 SVN client installation in Ubuntu
0 Getting error 403 (forbidden) when trying to access newly setup svn directory (apache)
0 how to minify the linux userspace on debian / ubuntu?
question feed
about help badges blog chat data legal privacy policy jobs advertising info mobile contact us feedback
TECHNOLOGY	 LIFE / ARTS	 CULTURE / RECREATION	 SCIENCE	 OTHER
Stack Overflow
Server Fault
Super User
Web Applications
Ask Ubuntu
Webmasters
Game Development
TeX - LaTeX
Programmers
Unix & Linux
Ask Different (Apple)
WordPress Answers
Geographic Information Systems
Electrical Engineering
Android Enthusiasts
IT Security
Database Administrators
Drupal Answers
SharePoint
User Experience
Mathematica
more (13)
Photography
Science Fiction & Fantasy
Seasoned Advice (cooking)
Home Improvement
more (13)
English Language & Usage
Skeptics
Mi Yodeya (Judaism)
Travel
Christianity
Arqade (gaming)
Bicycles
Role-playing Games
more (21)
Mathematics
Cross Validated (stats)
Theoretical Computer Science
Physics
MathOverflow
more (7)
Stack Apps
Meta Stack Overflow
Area 51
Stack Overflow Careers
site design / logo © 2013 stack exchange inc; user contributions licensed under cc-wiki with attribution required
rev 2013.8.26.972


