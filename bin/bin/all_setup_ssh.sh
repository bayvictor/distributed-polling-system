
sudo apt-get install -y openssh-server
sudo apt-get install -y chkconfig
echo "in a terminal do:"
sudo apt-get install -y ssh
echo "This should get sshd installed. Check by doing:"
sudo /etc/init.d/sshd restart

sudo apt-get install -y sshfs #- filesystem client based on SSH File Transfer Protocol
sudo apt-get install -y libghc-hfuse-dev #- Haskell binding for the Linux FUSE library
sudo apt-get install -y libghc-hfuse-prof #- Haskell binding for the Linux FUSE library; profiling library



sudo usermod -a -G fuse vhuang
echo "Configuring ssh and autofs
First I need to create a set of ssh-keys so I donÂt have to write my password every time the connection is established.

root@bohr:~# "
sudo ssh-keygen -t dsa

echo "Next the public key needs to be transported to the remote server (bar.com) with the login ÂtjanssonÂ.

root@bohr:~#"
ssh-copy-id -i .ssh/id_rsa.pub vhuang@67.169.184.156

echo "Now I need to create a folder where the remote folder should be mounted.

root@bohr:~#" 

sudo mkdir /mnt/sshfs

echo "The next thing is to add a line to the file /etc/auto.master but before this is done. I need to know the userid, so I run:

tjansson@bohr:~$cat /etc/passwd | grep tjansson
tjansson:x:1000:1000:Thomas Jansson,,,:/home/tjansson:/bin/bash

So my userid is 1000. The file in /etc/auto.master now needs the line:"


echo "/mnt/sshfs /etc/auto.sshfs uid=1000,gid=1000,--timeout=30,--ghost"
echo "next step will do: sudo vi /etc/auto.master , copy above line to it"
read read_line
sudo vi /etc/auto.master 
echo "and finally we need to create the file /etc/auto.sshfs and add lines similar to this:"

echo "bar -fstype=fuse,rw,nodev,nonempty,noatime,allow_other,max_read=65536 :sshfs\#vhuang@67.169.184.156\:" > /etc/auto.sshfs

echo "This will mount the remote system in the folder /mnt/sshfs/bar/ every timee I access that folder. If IÂm not using the folder for 30 seconds it will be unmounted. Absolutely amazing and very very useful."

echo "Final words
If you have several servers you just need to add line for each in the file /etc/auto.sshfs. Finally it should also be stated that the are some security considerations to take into account. If this done on a laptop and the laptop is stolen the burglar could gain access to the remote systems."

#References
#http://www.mccambridge.org/Â
#http://www.tjansson.dk/?p=18 <- In danish on sshfs, encfs and FUSE.
#
#    * Share/Bookmarksudo apt-get install openssh-server -y 
sudo apt-get install openssh-client -y


echo "Mind that if you leave the passphrase empty, anybody getting you private key (/home/user/.ssh/id_rsa) will be able to connect to your remote host.

I would recommend that you enter a passphrase, this passphrase will be use to \"unlock\" the key, mind that this passphrase is not related to the remote user password.

You can define another filename to save your keys to. This become handy when you have a different set of key pairs to different hosts

By now, you should have id_rsa and id_rsa.pub in ~/.ssh directory.
"
read readline
echo "
id_rsa is the so called private key. id_rsa.pub is the public key, the one you are going to upload on your server in order to be able to gain access to the remote machine using key authetication.

Do not share your private key, this key has to be your own, nobody but you will need to use it.
The need of a passphrase will save you a lot of trouble in case you lost it.

Now that we have our public/private key pair ready, we need to upload it to the remote machine and enable access with it.

"
echo "^C to break, anykey to ssh-keygen, see your id_rsa, id_rsa.pub in ~/.ssh!"
read readline


ssh-keygen
 
sudo apt-get install sshfs
ssh-keygen
ssh-copy-id -i $HOME/.ssh/id_rsa.pub ${USER}@v102

sudo gpasswd -a $USER fuse

echo "
SSH is a secure protocol for communicating between machines. SSHFS is a tool that uses SSH to enable mounting of a remote filesystem on a local machine; the network is (mostly) transparent to the user. Because SSHFS authenticates connections, you can be sure that only those who should have access to remote directories can mount them (as long as everything is configured properly).

Because SSH encrypts connections, no one can see your files as they are transferred over the network. And because SSHFS is built using FUSE, even your own root user can only see your files by logging in to your account with su.

Installation and Setup

Simply install the following package: sshfs, then add yourself to the fuse group:
"

sudo gpasswd -a $USER fuse
echo "Once you have added yourself to the fuse group, you should log out and log back in again for the change to take effect.
Command-line Usage

Now, assuming that you have an SSH server running on a remote machine, simply run the SSHFS command to mount the remote directory. In this example, the remote directory is /projects on remote host far. The local mount point is /mnt/far_projects.
"
read readline
mkdir /mnt/far_projects
sshfs -o idmap=user $USER@far:/projects /mnt/far_projects

echo "To unmount,

fusermount -u /mnt/far_projects

To add it to your /etc/fstab,

sshfs#$USER@far:/projects /home/$USER/far_projects fuse defaults,idmap=user 0 0

Note that you have to change $USER to your login name when editing fstab, but it is not necessary when typing commands (the shell does it for you in that case).

One thing to be aware of is that your UID (User ID, the unique number of your user on a system) is not necessarily the same on the two hosts. When you ls -l, the user name associated with each file is printed in the third column. However, in the filesystem, only UIDs are stored, and ls simply looks up the UID and finds the user name associated with it. In Unix, UIDs are what matter, not the user names. So if you're 1000 on the local host and 1003 on the remote host, the sshfs mounted directory would show a different user name for your files. This is not a problem, though, because the ssh server on the remote machine is what is actually reading and writing files. So even though it shows up in ls -l as a different UID, any changes will be done through the ssh server on the remote host, which will use the correct UID for the remote machine. Problems may arise if you attempt to use a program that looks at UIDs of files (e.g. ls prints the wrong user name).

The idmap=user option ensures that files owned by the remote user are owned by the local user. If you don't use idmap=user, files in the mounted directory might appear to be owned by someone else, because your computer and the remote computer have different ideas about the numeric user ID associated with each user name. idmap=user will not translate UIDs for other users.

Using the GUI

Alternatively you can mount a directory over SSHFS using the Gnome "Connect to Server" tool in the desktop Places menu. In the tool, set the service type to SSH and fill in the boxes as needed. If a password is required when connecting then you will be prompted for it. Unmounting a SSHFS connection is the same as for any other volume. Open the File Browser (Nautilus). In the Places panel on the left click the arrow next to the SSHFS mount you want to disconnect or right-click it and select "Unmount".

Keep Alive

Your ssh session will automatically log out if it is idle. To keep the connection active (alive) add this to ~/.ssh/config or to /etc/ssh/ssh_config on the client.

ServerAliveInterval 5

This will send a \"keep alive\" signal to the server every 5 seconds. You can usually increase this interval, and I use 120.

Links

    This page is based off of this howto.

    How to mount chrooted SSH filesystem, with special care with owners and permissions questions. 

Comment: Fantastic guide, with 11.10 in fstab default was only letting root mount, changed that to rw,user,auto all worked ok

SSHFS (last edited 2011-12-06 16:13:48 by kevindavies-kd)

The material on this wiki is available under a free license, see Copyright / License for details
You can contribute to this wiki, see Wiki Guide for details
"

sudo mkdir /mnt/v102

sudo mkdir /mnt/v102_far_projects

sudo chown vhuang /mnt/v102/sda1
sudo chown vhuang /mnt/v102/sda5
sudo chown vhuang /mnt/v102/sda9
sudo chown vhuang /mnt/v102/sda10
sudo chown vhuang /mnt/v102_far_projects


sshfs -o idmap=user vhuang@v102:/home/vhuang /mnt/v102_far_projects
sshfs -o idmap=user vhuang@v102:/sda1/home/vhuang /mnt/v102/sda1
sshfs -o idmap=user vhuang@v102:/sda5/home/vhuang /mnt/v102/sda5
sshfs -o idmap=user vhuang@v102:/sda9/home/vhuang /mnt/v102/sda9
sshfs -o idmap=user vhuang@v102:/sda10/home/vhuang /mnt/v102/sda10

#vhuang@vhuang-Aspire-5552:~/bin$ cat list_of_v102_volumes.txt >test.txt;cat test.txt|sed 's|^|sudo mkdir /mnt/v102/|g;s|$|;  |g'>test00.txt;cat test.txt |sed 's|^|sshfs -o idmap=user vhuang@v102:/|g;s|$| /mnt/v102/|g' >test01.txt; paste test00.txt test01.txt list_of_v102_volumes.txt |sed 's|\t||g'


sudo mkdir  /mnt/v102/sdc1
sudo mkdir  /mnt/v102/sdd1
sudo mkdir  /mnt/v102/sde1
sudo mkdir  /mnt/v102/sdf2
sudo mkdir  /mnt/v102/sdg1
sudo mkdir  /mnt/v102/sdh1
sudo mkdir  /mnt/v102/sdi1
sudo mkdir  /mnt/v102/sdj1
sudo mkdir  /mnt/v102/sdk1



sudo chown vhuang /mnt/v102/sdb3
sudo chown vhuang /mnt/v102/sdc1
sudo chown vhuang /mnt/v102/sdd1
sudo chown vhuang /mnt/v102/sde1
sudo chown vhuang /mnt/v102/sdf2
sudo chown vhuang /mnt/v102/sdg1
sudo chown vhuang /mnt/v102/sdh1
sudo chown vhuang /mnt/v102/sdi1
sudo chown vhuang /mnt/v102/sdj1
sudo chown vhuang /mnt/v102/sdk1


sudo mkdir /mnt/v102/sdb3;  sshfs -o idmap=user vhuang@v102:/sdb3/ /mnt/v102/sdb3
sudo mkdir /mnt/v102/sdc1;  sshfs -o idmap=user vhuang@v102:/sdc1/ /mnt/v102/sdc1
sudo mkdir /mnt/v102/sdd1;  sshfs -o idmap=user vhuang@v102:/sdd1/ /mnt/v102/sdd1/
sudo mkdir /mnt/v102/sde1;  sshfs -o idmap=user vhuang@v102:/sde1/ /mnt/v102/sde1/
sudo mkdir /mnt/v102/sdf2;  sshfs -o idmap=user vhuang@v102:/sdf2/ /mnt/v102/sdf2/
sudo mkdir /mnt/v102/sdg1;  sshfs -o idmap=user vhuang@v102:/sdg1/ /mnt/v102/sdg1/
sudo mkdir /mnt/v102/sdh1;  sshfs -o idmap=user vhuang@v102:/sdh1/ /mnt/v102/sdh1/
sudo mkdir /mnt/v102/sdi1;  sshfs -o idmap=user vhuang@v102:/sdi1/ /mnt/v102/sdi1/
sudo mkdir /mnt/v102/sdj1;  sshfs -o idmap=user vhuang@v102:/sdj1/ /mnt/v102/sdj1/
sudo mkdir /mnt/v102/sdk1;  sshfs -o idmap=user vhuang@v102:/sdk1/ /mnt/v102/sdk1/


echo "192.168.0.100 v100" >> /etc/hosts
echo "192.168.0.101 v101" >> /etc/hosts
echo "192.168.0.102 v102" >> /etc/hosts
echo "192.168.0.103 v103" >> /etc/hosts
echo "192.168.0.104 v104" >> /etc/hosts
echo "192.168.0.105 v105" >> /etc/hosts
echo "192.168.0.106 v106" >> /etc/hosts
echo "192.168.0.107 v107" >> /etc/hosts
echo "192.168.0.108 v108" >> /etc/hosts
echo "192.168.0.109 v109" >> /etc/hosts
echo "192.168.0.110 v110" >> /etc/hosts
echo "192.168.0.111 v111" >> /etc/hosts
echo "192.168.0.112 v112" >> /etc/hosts
echo "192.168.0.113 v113" >> /etc/hosts
echo "192.168.0.114 v114" >> /etc/hosts
echo "192.168.0.115 v115" >> /etc/hosts
echo "192.168.0.116 v116" >> /etc/hosts
echo "192.168.0.117 v117" >> /etc/hosts
echo "192.168.0.118 v118" >> /etc/hosts
echo "192.168.0.119 v119" >> /etc/hosts
echo "192.168.0.120 v120" >> /etc/hosts
echo "192.168.0.121 v121" >> /etc/hosts
echo "192.168.0.122 v122" >> /etc/hosts
echo "192.168.0.123 v123" >> /etc/hosts
echo "192.168.0.124 v124" >> /etc/hosts
echo "192.168.0.125 v125" >> /etc/hosts
echo "192.168.0.126 v126" >> /etc/hosts
echo "192.168.0.127 v127" >> /etc/hosts
echo "192.168.0.128 v128" >> /etc/hosts
echo "192.168.0.129 v129" >> /etc/hosts
echo "192.168.0.130 v130" >> /etc/hosts
echo "192.168.0.131 v131" >> /etc/hosts
echo "192.168.0.132 v132" >> /etc/hosts
echo "192.168.0.133 v133" >> /etc/hosts
echo "192.168.0.134 v134" >> /etc/hosts
echo "192.168.0.135 v135" >> /etc/hosts
echo "192.168.0.136 v136" >> /etc/hosts
echo "192.168.0.137 v137" >> /etc/hosts
echo "192.168.0.138 v138" >> /etc/hosts
echo "192.168.0.139 v139" >> /etc/hosts
 
