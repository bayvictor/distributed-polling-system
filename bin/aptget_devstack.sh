echo "You need to have a system with a fresh install of Linux. You can download the Minimal CD for Ubuntu releases since DevStack will download & install all the additional dependencies. The netinstall ISO is available for Fedora and CentOS/RHEL. You may be tempted to use a desktop distro on a laptop, it will probably work but you may need to tell Network Manager to keep its fingers off the interface(s) that OpenStack uses for bridging.
Network Configuration

Determine the network configuration on the interface used to integrate your OpenStack cloud with your existing network. For example, if the IPs given out on your network by DHCP are 192.168.1.X - where X is between 100 and 200 you will be able to use IPs 201-254 for floating ips.

To make things easier later change your host to use a static IP instead of DHCP (i.e. 192.168.1.201).
Installation shake and bake
Add your user

We need to add a user to install DevStack. (if you created a user during install you can skip this step and just give the user sudo privileges below)
"
sudo adduser stack
echo "
Since this user will be making many changes to your system, it will need to have sudo privileges:
"
apt-get install sudo -y || yum install -y sudo
echo "stack ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo "
From here on you should use the user you created. Logout and login as that user.
Download DevStack

We’ll grab the latest version of DevStack via https:
"
sudo apt-get install git -y || sudo yum install -y git
git clone https://git.openstack.org/openstack-dev/devstack
cd devstack
./stack.sh


