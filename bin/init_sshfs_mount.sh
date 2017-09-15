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

