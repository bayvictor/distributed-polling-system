echo" The first step is to install the samba package. From a terminal prompt enter:
"
sudo apt-get install -y samba

echo "That's all there is to it; you are now ready to configure Samba to share files.
Configuration

The main Samba configuration file is located in /etc/samba/smb.conf. The default configuration file has a significant amount of comments in order to document various configuration directives.
[Note] 	

Not all the available options are included in the default configuration file. See the smb.conf man page or the Samba HOWTO Collection for more details.

   1.
"
echo"      First, edit the following key/value pairs in the [global] section of /etc/samba/smb.conf:"
read read_line
echo "
         workgroup = EXAMPLE
         ...
         security = user

      The security parameter is farther down in the [global] section, and is commented by default. Also, change EXAMPLE to better match your environment.
   2.
"
sudo emacs /etc/samba/smb.conf &
read read_line
echo "      Create a new section at the bottom of the file, or uncomment one of the examples, for the directory to be shared:

      [share]
          comment = Ubuntu File Server Share
          path = /srv/samba/share
          browsable = yes
          guest ok = yes
          read only = no
          create mask = 0755
"
read read_line
echo "
          *

            comment: a short description of the share. Adjust to fit your needs.
          *

            path: the path to the directory to share.
"
read read_line

echo"            This example uses /srv/samba/sharename because, according to the Filesystem Hierarchy Standard (FHS), /srv is where site-specific data should be served. Technically Samba shares can be placed anywhere on the filesystem as long as the permissions are correct, but adhering to standards is recommended.
          *

            browsable: enables Windows clients to browse the shared directory using Windows Explorer.
          *
"
read read_line
 echo "           guest ok: allows clients to connect to the share without supplying a password.
          *

            read only: determines if the share is read only or if write privileges are granted. Write privileges are allowed only when the value is no, as is seen in this example. If the value is yes, then access to the share is read only.
          *

            create mask: determines the permissions new files will have when created. "
echo "   3.

      Now that Samba is configured, the directory needs to be created and the permissions changed. From a terminal enter:
"
read read_line

sudo mkdir -p /srv/samba/share
sudo chown nobody.nogroup /srv/samba/share/
read read_line
echo"      [Note] 	

      The -p switch tells mkdir to create the entire directory tree if it doesn't exist. Change the share name to fit your environment.
   4."

echo"      Finally, restart the samba services to enable the new configuration:
"
      sudo /etc/init.d/samba restart

echo "[Warning] 	

Once again, the above configuration gives all access to any client on the local network. For a more secure configuration see the section called -Y´Securing a Samba File and Print Server¡.

From a Windows client you should now be able to browse to the Ubuntu file server and see the shared directory. To check that everything is working try creating a directory from Windows.

To create additional shares simply create new [dir] sections in /etc/samba/smb.conf, and restart Samba. Just make sure that the directory you want to share actually exists and the permissions are correct.
"

sudo apt-get install -y nautilus-share
