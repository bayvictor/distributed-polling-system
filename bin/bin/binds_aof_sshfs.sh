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
#    * Share/Bookmark