#!/bin/bash

echo "install NFS Serve"
sudo apt-get install -y portmap nfs-kernel-server
read read_line

read read_line

echo "After setting up /etc/exports, export the shares:"

sudo exportfs -ra
echo "You'll want to do this command whenever /etc/exports is modified.
"
read read_line


echo "Restart Services
By default, portmap only binds to the loopback interface. To enable access to portmap from remote machines, you need to change /etc/default/portmap to get rid of either "-l" or "-i 127.0.0.1".

If /etc/default/portmap was changed, portmap will need to be restarted:
"
read read_line


sudo /etc/init.d/portmap restart
echo "The NFS kernel server will also require a restart:"

read read_line

sudo /etc/init.d/nfs-kernel-server restart

echo "ins nfs client..."

sudo apt-get install -y portmap nfs-common

echo "Portmap Lockdown
optional"

echo "Add the following line to /etc/hosts.deny:

portmap : ALL
By blocking all clients first, only clients in /etc/hosts.allow below will be allowed to access the server.

Now add the following line to /etc/hosts.allow:

portmap : NFS server IP address"

echo 'Where "NFS server IP address" is the IP address of the server. This must be numeric! It is the way portmap works.

Host Names
optional if using DNS'

read read_line

echo "Add the server name to /etc/hosts. This ensures the NFS mounts will still work even if DNS goes down. You could rely on DNS if you wanted, it's up to you."
read read_line
echo "
Mounts
Check to see if everything works
You should try and mount it now. The basic template you will use is:"
read read_line
sudo mount ServerIP:/folder/already/setup/to/be/shared /home/username/folder/in/your/local/computer

echo "so for example:"

sudo mount 192.168.1.42:/home/music /home/poningru/music

echo "Mount at startup
NFS mounts can either be automatically mounted when accessed using autofs or can be setup with static mounts using entries in /etc/fstab."

echo "Automounter
Install autofs:"

sudo apt-get install -y autofs


