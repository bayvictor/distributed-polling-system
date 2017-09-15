echo "
Quick Start

    Select a Linux Distribution

    Only Ubuntu 14.04 (Trusty), Fedora 20 and CentOS/RHEL 7 are documented here. OpenStack also runs and is packaged on other flavors of Linux such as OpenSUSE and Debian.

    Install Selected OS

    In order to correctly install all the dependencies, we assume a specific minimal version of the supported distributions to make it as easy as possible. We recommend using a minimal install of Ubuntu or Fedora server in a VM if this is your first time.
    ^C to break, any key to Download DevStack

"
read readline
mkdir ~/src/
cd ~/src/

    git clone https://git.openstack.org/openstack-dev/devstack

echo "
    The devstack repo contains a script that installs OpenStack and templates for configuration files

    Configure

    We recommend at least a minimal configuration be set up.

    Start the install
    ^C to break, any key to install  DevStack minimal configuration for OpenStack setting up...
   click gedit to read script will be running....
"
read readline
gedit ./devstack/stack.sh &

cd devstack; ./stack.sh

echo "
    It takes a few minutes, we recommend reading the script while it is building.

"


