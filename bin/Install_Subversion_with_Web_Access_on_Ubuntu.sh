#Install_Subversion_with_Web_Access_on_Ubuntu  


echo "This article covers installing subversion with the apache module so that it can be easily accessed from other systems on a public network. If you want a more secure svn server, you could use svnserve+ssh, which isn’t covered in this article.

To install subversion, open a terminal and run the following command:
"
    sudo apt-get install subversion libapache2-svn

echo "We’re going to create the subversion repository in /svn, although you should choose a location that has a good amount of space.
"
    sudo svnadmin create /svn
echo "open a new terminal! then copy-paste below lines into it!"


echo "Next we’ll need to edit the configuration file for the subversion webdav module. You can use a different editor if you’d like.
    sudo gedit /etc/apache2/mods-enabled/dav_svn.conf

The Location element in the configuration file dictates the root directory where subversion will be acessible from, for instance: http://www.server.com/svn

    <Location /svn>

The DAV line needs to be uncommented to enable the dav module

    # Uncomment this to enable the repository,
    DAV svn

The SVNPath line should be set to the same place your created the repository with the svnadmin command.

    # Set this to the path to your repository
    SVNPath /svn

The next section will let you turn on authentication. This is just basic authentication, so don’t consider it extremely secure. The password file will be located where the AuthUserFile setting sets it to…  probably best to leave it at the default.

    # Uncomment the following 3 lines to enable Basic Authentication
    AuthType Basic
    AuthName “Subversion Repository”
    AuthUserFile /etc/apache2/dav_svn.passwd

To create a user on the repository use, the following command:

come back to this line if you done with editor and save!!!!!!!!!!!!!
"
    sudo gedit /etc/apache2/mods-enabled/dav_svn.conf &

read readline
echo "^C to break, anykey to continue to do below:
    sudo htpasswd2 -cm /etc/apache2/dav_svn.passwd <username>
"
read readline
echo "Note that you should only use the -c option the FIRST time that you create a user. After that you will only want to use the -m option, which specifies MD5 encryption of the password, but doesn’t recreate the file.
"
read readline
    sudo htpasswd2 -cm /etc/apache2/dav_svn.passwd $USER

echo "Example:

    sudo htpasswd2 -cm /etc/apache2/dav_svn.passwd geek
    New password:
    Re-type new password:
    Adding password for user geek

Restart apache by running the following command:
"
    sudo /etc/init.d/apache2 restart

echo "Now if you go in your browser to http://www.server.com/svn, you should see that the repository is enabled for anonymous read access, but commit access will require a username.

If you want to force all users to authenticate even for read access, add the following line right below the AuthUserFile line from above. Restart apache after changing this line.

    Require valid-user

Now if you refresh your browser, you’ll be prompted for your credentials:

You now have a working subversion server!
Don't show again X

"





















