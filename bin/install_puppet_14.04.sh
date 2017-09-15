cd ~/src/openstack
mkdir puppet
cd puppet
#wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
sudo dpkg -i puppetlabs-release-trusty.deb
sudo apt-get update
echo "Step 2: Install Puppet on the Puppet Master Server
(Skip this step for a standalone deployment.)

On your puppet master node, run one of the following:

sudo apt-get install puppetmaster-passenger
"

echo "^C to break, anykey to continue...."; read readline

sudo apt-get install puppetmaster-passenger
echo " — We recommend this one, as it will save you a step in the post-install tasks. It will install Puppet and its prerequisites, and automatically configure a production-capacity web server.
sudo apt-get install puppetmaster — This will install Puppet, its prerequisites, and an init script (/etc/init.d/puppetmaster) for running a test-quality puppet master server.
Do not start the puppet master service yet.
i"

echo "^C to break, anykey to continue...."; read readline
echo "Upgrading

Note: Be sure to read our tips on upgrading before upgrading your whole Puppet deployment.

To upgrade to the latest version of Puppet, you can run:
will do in next line:
sudo apt-get update
sudo puppet resource package puppetmaster ensure=latest


$ "

sudo apt-get update
sudo puppet resource package puppetmaster ensure=latest



echo "^C to break, anykey to continue...."; read readline
echo "
You’ll need to restart the puppet master web server after upgrading.

Step 3: Install Puppet on Agent Nodes
On your other nodes, run sudo apt-get install puppet. This will install Puppet and an init script (/etc/init.d/puppet) for running the puppet agent daemon.

Do not start the puppet service yet.

Upgrading

Note: Be sure to read our tips on upgrading before upgrading your whole Puppet deployment.

To upgrade to the latest version of Puppet, you can run:
sudo apt-get update
sudo puppet resource package puppet ensure=latest

$ "

echo "^C to break, anykey to continue...."; read readline
sudo apt-get update
sudo puppet resource package puppet ensure=latest

echo "You’ll need to restart the puppet service after upgrading.

Next
At this point, Puppet is installed, but it isn’t configured or running. You should now do the post-install tasks.
"

echo "^C to break, anykey to continue...."; read readline

