echo " 
17
AUGUST
2013
How to Configure NFS (Network File System) on Ubuntu
Written by Rahul

 Network Services, NFS, Ubuntu  Leave a Comment 

 
Network File System (NFS) is a distributed file system protocol. which allowing a user on a client computer to access files over a network in a manner similar to how local storage is accessed.

This article will help you to install and configure NFS on Ubuntu systems and export an directory and mount it on client system.

Network Details:

We have running two Ubuntu 12.04 LTS Systems in same network 192.168.1.0/24, Below given ips are configured on server and client, which we will use in this tutorial.

Server: 192.168.1.100
Client: 192.168.1.110
Step 1: Set Up NFS Server on Ubuntu

In this step we will describe you to what packages you need to install and how to install them. Also describes who to export and directory using NFS server.

1.1 – Install Pacakges
Use following command to install required packages to configure NFS server.

sudo apt-get install nfs-kernel-server portmap
C
$ "


echo "^C to break, any other key to continue \"on server \" sudo apt-get install nfs and portmap ...";read readreadline
sudo apt-get install nfs-kernel-server portmap



echo "1.2 – Export Directory
After completing package installation, we need to configure nfs to export directory. For this tutorial we are creating a new directory, you may use any existing directory also.
sudo mkdir /var/www/share

$ sudo vi /etc/exports
$
 "
echo "^C to break, any other key to continue mkdir share, and vi /etc/exports ...";read readreadline

sudo mkdir /var/www
sudo mkdir /var/www/share

sudo mkdir /var/www/share/v102  
sudo mkdir /var/www/share/v108  
sudo mkdir /var/www/share/v109  
sudo mkdir /var/www/share/v114 
sudo mkdir /var/www/share/v118  
sudo mkdir /var/www/share/v123  

sudo chown nobody:nogroup /var/www/share

echo "Configure NFS to export above created directory and home directory. So that this directory can be accessible over network using NFS.
copy paste below into /etc/exports   :  #B
"

echo "
/home             192.168.1.0/24(rw,sync,no_root_squash,no_subtree_check)
/var/www/share    192.168.1.110(rw,sync,no_subtree_check)
next will do: vi /etc/exports
$ "

 sudo vi /etc/exports

echo "
After configuring /etc/exports execute following command to export.
sudo exportfs -a
next will do:
"
sudo exportfs -a
echo "^C to break, any other key to continue...";read readreadline

echo "1.3 – Verify Exported Directory
To confirm and view exported directory use following command and you will get output like below

$ "

echo "^C to break, any other key to continue...";read readreadline
sudo exportfs -v

echo "[Samput Output]
/home           192.168.1.0/24(rw,wdelay,no_root_squash,no_subtree_check)
/var/www/share  192.168.1.110(rw,wdelay,no_root_squash,no_subtree_check)
Step 2: Set Up NFS Client

After completing set up on server side, login to clients system where we need to configure nfs client and mount exported directory by nfs server.

2.1 – Install Packages
Install following packages on NFS client system, which is required to mount remote directory using nfs.

sudo apt-get install nfs-common portmap
$ "

echo "^C to break, any other key to continue...";read readreadline
sudo apt-get install nfs-common portmap

echo "2.2 – Mount Remote Exported Directory
Now we need to create mount points for mounting remote nfs exported directories.

$ "
sudo mkdir /mnt/share
sudo mkdir /mnt/home


echo "^C to break, any other key to continue...";read readreadline
echo "After creating mount point, mount remote NFS exported directory using following command.

$ "

echo "^C to break, any other key to continue...";read readreadline
sudo mount 192.168.1.100:/var/www/share /mnt/share
sudo mount 192.168.1.100:/home /mnt/home


echo "^C to break, any other key to continue...";read readreadline
echo "2.3 – Verify Mounted Directory
Check mounted file system using below commands. As per below output both nfs mounted directories are listed at end of result.

$ "

echo "^C to break, any other key to continue...";read readreadline
sudo df -h

echo  "[Sample Output]
Filesystem                    Size  Used Avail Use% Mounted on
/dev/sda1                      20G  2.8G   16G  16% /
udev                          371M  4.0K  371M   1% /dev
tmpfs                         152M  812K  151M   1% /run
none                          5.0M     0  5.0M   0% /run/lock
none                          378M  8.0K  378M   1% /run/shm
/dev/sr0                       32M   32M     0 100% /media/CDROM
/dev/sr1                      702M  702M     0 100% /media/Ubuntu 12.04 LTS i386
192.168.1.100:/var/www/share   20G  2.8G   16G  16% /mnt/share
192.168.1.100:/home            20G  2.8G   16G  16% /mnt/home

"

echo "^C to break, any other key to continue...";read readreadline
2.4 Set Up Auto Mount
Add the following lines in /etc/fstab to mount NFS directories automatically after system reboot. This will mount directories on start up after the server reboots.



192.168.1.100:/home  /mnt/home   nfs      auto,noatime,nolock,bg,nfsvers=3,intr,tcp,actimeo=1800 0 0
192.168.1.100:/var/www/share  /mnt/share   nfs     auto,noatime,nolock,bg,nfsvers=3,intr,tcp,actimeo=1800 0 0
2.5 – Unmount NFS Mount Point
If you want to remove mounted file system, You can simply unmounted it using umount command. Also you need to remove entries from /etc/fstab (if added)
"
echo "^C to break, any other key to continue...";read readreadline
sudo vi /etc/fstab


echo "
# sudo umount /mnt/share
# sudo umount /mnt/home
"
  
echo "^C to break, any other key to continue...";read readreadline

 
echo "SHARE ON

RAHUL  
Founder of TecAdmin.net. I love to work with Linux and other open source application. Also I like to share knowledge with my friends and other Linux users. Follow me on Twitter, Add me on Google+ or Like Facebook page.

zend-instll
  PREVIOUS ARTICLE
How to Install PHP Zend Framework on Linux Server
munin-setup
NEXT ARTICLE  
Installing Munin Network Monitoring in CentOS RHEL and Fedora
After Embroidery Design How To Video Tutorials Avail Pages
Replies Equibase horse racing Windows media player Application
LEAVE A REPLY

NAME * EMAIL * WEBSITE
COMMENTS *
"

echo "^C to break, any other key to continue...";read readreadline
 


