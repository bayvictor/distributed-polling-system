echo "Installing and configuring the Ubuntu Redmine package
Configuring Apache
Backing up Redmine
Additional semi-optional packages
Email setup
Revision control repository setup
This tutorial walks you step-by-step through installing Redmine on a clean/fresh Ubuntu 12.04 installation. This is intended to be a complete cookbook method for getting Redmine installed and running. It makes no assumptions about other things being installed or configured. Since I have had some issues when using the graphical package managers, we will be doing this from the command line prompt to keep things as clear and clean as possible.

I recommend that you install any Ubuntu updates prior to beginning this process. There are almost always some waiting to be applied after Ubuntu is first set up.

Prerequisites: Apache, mod-passenger, and MySQL
There are several support packages that we will install first. The apache installation is pretty simple if you just follow the prompts and accept the defaults.

$ "
sudo apt-get install apache2 libapache2-mod-passenger
echo "Installing mysql takes just a little more, so the details are spelled out.

$ "

sudo apt-get install mysql-server mysql-client 
echo "The installation process for mysql is going to prompt you for a password for the \"root\" access for the database server, then ask you to confirm the password in a follow-up screen. This sets the database adminstration password.

Package configuration                                                           

  ┌────────────────────┤ Configuring mysql-server-5.5 ├─────────────────────┐   
  │ While not mandatory, it is highly recommended that you set a password   │   
  │ for the MySQL administrative \"root\" user.                               │   
  │                                                                         │   
  │ If this field is left blank, the password will not be changed.          │   
  │                                                                         │   
  │ New password for the MySQL \"root\" user:                                 │   
  │                                                                         │   
  │ _______________________________________________________________________ │   
  │                                                                         │   
  │                                 <Ok>                                    │   
  │                                                                         │   
  └─────────────────────────────────────────────────────────────────────────┘   

  ┌────┤ Configuring mysql-server-5.5 ├──────────┐
  │                                              │
  │ Repeat password for the MySQL \"root\" user.   │
  │                                              │
  │                                              │
  │ ____________________________________________ │
  │                                              │
  │                   <Ok>                       │
  │                                              │
  └──────────────────────────────────────────────┘
Installing and configuring the Ubuntu Redmine package
Now it is time to install redmine itself. 

$ "
sudo apt-get install redmine redmine-mysql
echo "You want to allow dbconfig-common to configure the database when prompted so select Yes from the prompt in the panel below.

Package configuration                                                           

 ┌──────────────────────────┤ Configuring redmine ├──────────────────────────┐  
 │                                                                           │  
 │ The redmine/instances/default package must have a database installed and  │  
 │ configured before it can be used.  This can be optionally handled with    │  
 │ dbconfig-common.                                                          │  
 │                                                                           │  
 │ If you are an advanced database administrator and know that you want to   │  
 │ perform this configuration manually, or if your database has already      │  
 │ been installed and configured, you should refuse this option.  Details    │  
 │ on what needs to be done should most likely be provided in                │  
 │ /usr/share/doc/redmine/instances/default.                                 │  
 │                                                                           │  
 │ Otherwise, you should probably choose this option.                        │  
 │                                                                           │  
 │ Configure database for redmine/instances/default with dbconfig-common?    │  
 │                                                                           │  
 │                    <Yes>                       <No>                       │  
 │                                                                           │  
 └───────────────────────────────────────────────────────────────────────────┘  
Then you want to provide the \"root\" password for the database, so that the installer can create the redmine database. This is the password set when you installed mysql.

Package configuration                                                           

 ┌──────────────────────────┤ Configuring redmine ├──────────────────────────┐  
 │ Please provide the password for hte administrative account with which     │  
 │ this package should create its MySQL database and user.                   │  
 │                                                                           │  
 │ Password of the database's administrative user:                           │  
 │                                                                           │  
 │ ******__________________________________________________________________  │  
 │                                                                           │  
 │                   <Ok>                       <Cancel>                     │  
 │                                                                           │  
 └───────────────────────────────────────────────────────────────────────────┘  
Tell the redmine installer we are using mysql for this installation by highlighting \"mysql\" from the list of database choices:

Package configuration                                                           

 ┌──────────────────────────┤ Configuring redmine ├──────────────────────────┐  
 │ The redmine/instances/default package can be configured to use one of     │  
 │ several database types. Below, you will be presented with the available   │  
 │ choices.                                                                  │  
 │                                                                           │  
 │ Database type to be used by redmine/instances/default:                    │  
 │                                                                           │  
 │                                  sqlite3                                  │  
 │                                  pgsql                                    │  
 │                                  mysql                                    │  
 │                                                                           │  
 │                                                                           │  
 │                    <Ok>                        <Cancel>                   │  
 │                                                                           │  
 └───────────────────────────────────────────────────────────────────────────┘  
Now you are asked to provide a password that will be used to protect the redmine database. Redmine itself will use this when it wants to access mysql.

Package configuration                                                           

 ┌──────────────────────────┤ Configuring redmine ├──────────────────────────┐  
 │ Please provide a password for redmine/instances/default to register with  │  
 │ the database server.  If left blank, a random password will be            │  
 │ generated.                                                                │  
 │                                                                           │  
 │ MySQL application password for redmine/instances/default:                 │  
 │                                                                           │  
 │ *******__________________________________________________________________ │  
 │                                                                           │  
 │                    <Ok>                        <Cancel>                   │  
 │                                                                           │  
 └───────────────────────────────────────────────────────────────────────────┘ 
Now confirm the redmine password.

Package configuration                                                           

   ┌────┤ Configuring redmine ├─────┐                       
   │                                │                       
   │                                │                       
   │ Password confirmation:         │                       
   │                                │                       
   │ *******_______________________ │                       
   │                                │                       
   │     <Ok>         <Cancel>      │                       
   │                                │                       
   └────────────────────────────────┘   
Configuring Apache
You need to modify two files for apache. The first is /etc/apache2/mods-available/passenger.conf which needs the text PassengerDefaultUser www-data added as seen here:
"
sudo echo "
<IfModule mod_passenger.c>
  PassengerDefaultUser www-data
  PassengerRoot /usr
  PassengerRuby /usr/bin/ruby
</IfModule>
" >> /etc/apache2/mods-available/passenger.conf 

sudo gedit /etc/apache2/mods-available/passenger.conf &


echo "Now create a symlink to connect Redmine into the web document space:

$ "
sudo ln -s /usr/share/redmine/public /var/www/redmine
echo "And modify /etc/apache2/sites-available/default to insert the following with the other <Directory> sections so that apache knows to follow the symlink into Rails:
"
sudo echo "
<Directory /var/www/redmine>
    RailsBaseURI /redmine
    PassengerResolveSymlinksInDocumentRoot on
</Directory>

">> /etc/apache2/sites-available/default


echo "Now restart apache:

$ "

sudo service apache2 restart
echo "You should now be able to access redmine from the local host

$ firefox http://127.0.0.1/redmine
In the upper right corner of the browser window you should see the "Sign in" link. Click that and enter "admin" at both the Login: and Password: prompts. Note: this is not the password you set during the installation process. Click the Login button.

I recommend that the next thing you do is to click on My account in the upper right corner and change that password. In the page that is displayed there should be a Change password link in the upper right of the white area of the page. Click to change the password.

Backing up Redmine
You should arrange a regular backup of the Redmine database and the files that users upload/attach. The database can be dumped to a text file with:

/usr/bin/mysqldump -u root -p<password> redmine_default | gzip > /path/to/backups/redmine_db_`date +%y_%m_%d`.gz
where <password> is the one you set when installing mysql.
The attachments are stashed in /var/lib/redmine/default/files and can be backed up with something like:

rsync -a /var/lib/redmine/default/files /path/to/backups/files
You can have these commands run automatically by creating a script called /etc/cron.daily/redmine that contains:

#!/bin/sh
/usr/bin/mysqldump -u root -p<password> redmine_default | gzip > /path/to/backups/redmine_db_`date +%y_%m_%d`.gz
rsync -a /var/lib/redmine/default/files /path/to/backups/files
Again, be sure to substitute the mysql root password for <password> in the mysqldump command line. The file should be protected so that only root has read permission because you are storing the root password for your mysql installation in this file. That the first line creates a new file every time the script is run. This can eventually create a large number of backups of your database files. You should have a script that purges old ones periodically.

Additional semi-optional packages
There are some services that Redmine can use that are not absolutely necessary, but are useful. These are email and software repository/revision control systems.

Email setup
At some point you will probably want Redmine to be able to send email. For this you will need to install and configure email. This can be achieved by installing the postfix package. I do not recommend the exim4 package, as there have been some incompatibilities in the way the "sendmail" command line is handled between Redmine and exim4. Unless everyone has an email account on the redmine server you will want to set up external email as a full internet host. Once email service is installed, you will have to restart apache for Redmine to know that it has access to email services.

$ sudo apt-get install postfix
Now that you can send email, you have to tell Redmine about it. You need to create/edit the file /etc/redmine/default/configuration.yml and add the following lines:

production:
  email_delivery:
    delivery_method: :sendmail
Then restart apache so that Redmine reloads the configuration file:

$ sudo service apache2 restart
Revision control repository setup
In order to have your software repository on the system Redmine will need the corresponding software installed.

$ sudo apt-get install git subversion cvs mercurial
$ sudo service apache2 restart
That covers it as far as I have gotten in my use of Redmine to date.

Powered by Redmine © 2006-2013 Jean-Philippe Lang

"

