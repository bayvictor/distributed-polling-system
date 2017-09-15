echo "Free and Open Source Software Knowledge Base
Menu
BUNDLING DIFFERENT IMAGES FOR OPENSTACK
OpenStack Juno on Ubuntu 14.10 – Single Machine Setup

Install Ubuntu with partitioning scheme as per your requirements. Note: Run all the commands as super-user. We assume that the IP of the Single machine is 127.0.0.1.

Update the packages.
"
sudo apt-get -y install libapache2-mod-auth-mysql php5-mysql phpmyadmin


apt-get update -y && apt-get -y upgrade
echo "Note: Reboot is needed only if kernel is updated
"

echo "^C to break, anyother key to reboot ...";read readline

reboot 
echo "Support packages

RaabitMQ server
"

apt-get install -y rabbitmq-server
echo "Change Password for the user ‘guest’ in the rabbitmq-server

rabbitmqctl change_password guest rabbit
MySQL server

Install MySQL server and related software
"

echo "^C to break, anyother key to continue...";read readline

apt-get install -y mysql-server python-mysqldb


echo "Edit the following lines in /etc/mysql/my.cnf
bind-address = 0.0.0.0
[mysqld]
...
default-storage-engine = innodb
innodb_file_per_table
collation-server = utf8_general_ci
init-connect = 'SET NAMES utf8'
character-set-server = utf8
Restart MySQL service
"

echo "^C to break, anyother key to continue...";read readline

service mysql restart


apt-get install -y ntp vlan bridge-utils

echo "
Edit the following lines in the file /etc/sysctl.conf
net.ipv4.ip_forward=1
net.ipv4.conf.all.rp_filter=0
net.ipv4.conf.default.rp_filter=0
Load the values
"

echo "^C to break, anyother key to continue...";read readline
sysctl -p

echo "Keystone

Install keystone
"
apt-get install -y keystone

echo "
Create mysql database named keystone and add credentials

mysql -u root -p
mysql> CREATE DATABASE keystone;
mysql> GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' IDENTIFIED BY 'keystone_dbpass';
mysql> quit
Edit the file /etc/keystone/keystone.conf. Comment the following line

connection = sqlite:////var/lib/keystone/keystone.db
and add the line

connection = mysql://keystone:keystone_dbpass@127.0.0.1/keystone
Restart the keystone service and sync the database
"

service keystone restart
keystone-manage db_sync

echo "^C to break, anyother key to continue...";read readline
echo "
Export the variable to run initial keystone commands
"
export OS_SERVICE_TOKEN=ADMIN
export OS_SERVICE_ENDPOINT=http://127.0.0.1:35357/v2.0

echo "Create admin user, admin tenant, admin role and service tenant. Also add admin user to admin tenant and admin role.
"

keystone tenant-create --name=admin --description="Admin Tenant"
keystone tenant-create --name=service --description="Service Tenant"
keystone user-create --name=admin --pass=ADMIN --email=admin@example.com
keystone role-create --name=admin
keystone user-role-add --user=admin --tenant=admin --role=admin
Create keystone service

keystone service-create --name=keystone --type=identity --description="Keystone Identity Service"
Create keystone endpoint

keystone endpoint-create --service=keystone --publicurl=http://127.0.0.1:5000/v2.0 --internalurl=http://127.0.0.1:5000/v2.0 --adminurl=http://127.0.0.1:35357/v2.0

echo "^C to break, anyother key to continue...";read readline

echo "Unset the exported values
"
unset OS_SERVICE_TOKEN
unset OS_SERVICE_ENDPOINT
echo "Create a file named creds and add the following lines
"
export OS_USERNAME=admin
export OS_PASSWORD=ADMIN
export OS_TENANT_NAME=admin
export OS_AUTH_URL=http://127.0.0.1:35357/v2.0
#Source the file
echo "
source creds
"

echo "

Test the keysone setup
"
keystone token-get
keystone user-list

echo "^C to break, anyother key to continue...";read readline
echo "
Glance (Image Store)

Install Glance
"
apt-get install -y glance

echo "Create database and credentials for Glance

mysql -u root -p
CREATE DATABASE glance;
GRANT ALL ON glance.* TO 'glance'@'%' IDENTIFIED BY 'glance_dbpass';
quit;
Create glance related keystone entries
"


echo "^C to break, anyother key to continue...";read readline
keystone user-create --name=glance --pass=glance_pass --email=glance@example.com
keystone user-role-add --user=glance --tenant=service --role=admin
keystone service-create --name=glance --type=image --description="Glance Image Service"
keystone endpoint-create --service=glance --publicurl=http://127.0.0.1:9292 --internalurl=http://127.0.0.1:9292 --adminurl=http://127.0.0.1:9292
echo "Edit /etc/glance/glance-api.conf and edit the following lines

# sqlite_db = /var/lib/glance/glance.sqlite
connection = mysql://glance:glance_dbpass@127.0.0.1/glance

[keystone_authtoken]
auth_uri = http://127.0.0.1:5000/v2.0
identity_uri = http://127.0.0.1:35357
admin_tenant_name = service
admin_user = glance
admin_password = glance_pass

[paste_deploy]
flavor = keystone
Edit /etc/glance/glance-registry.conf and edit the following lines as below

# sqlite_db = /var/lib/glance/glance.sqlite
connection = mysql://glance:glance_dbpass@127.0.0.1/glance

[keystone_authtoken]
auth_uri = http://127.0.0.1:5000/v2.0
identity_uri = http://127.0.0.1:35357
admin_tenant_name = service
admin_user = glance
admin_password = glance_pass

[paste_deploy]
flavor = keystone
Restart Glance services
"

echo "^C to break, any key to continue....";read readline

service glance-api restart
service glance-registry restart
echo "Sync the database
"
glance-manage db_sync
echo "Download a pre-bundled image for testing
"
glance image-create --name Cirros --is-public true --container-format bare --disk-format qcow2 --location https://launchpad.net/cirros/trunk/0.3.0/+download/cirros-0.3.0-x86_64-disk.img
glance image-list
echo "Nova(Compute)

Install the Nova services
"

echo "^C to break, any key to continue....";read readline

apt-get install -y nova-api nova-cert nova-conductor nova-consoleauth nova-novncproxy nova-scheduler python-novaclient nova-compute nova-console
echo "Create database and credentials for Nova



mysql -u root -p
mysql> CREATE DATABASE nova;
mysql> GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'%' IDENTIFIED BY 'nova_dbpass';
mysql> quit
Create Keystone entries for Nova
"
echo "^C to break, any key to continue....";read readline
keystone user-create --name=nova --pass=nova_pass --email=nova@example.com
keystone user-role-add --user=nova --tenant=service --role=admin
keystone service-create --name=nova --type=compute --description="OpenStack Compute"
keystone endpoint-create --service=nova --publicurl=http://127.0.0.1:8774/v2/%\(tenant_id\)s --internalurl=http://127.0.0.1:8774/v2/%\(tenant_id\)s --adminurl=http://127.0.0.1:8774/v2/%\(tenant_id\)s


echo "^C to break, any key to continue....";read readline

echo "Open /etc/nova/nova.conf and edit the file as follows

[DEFAULT]
logdir=/var/log/nova
state_path=/var/lib/nova
lock_path=/var/lock/nova
force_dhcp_release=True
iscsi_helper=tgtadm
libvirt_use_virtio_for_bridges=True
connection_type=libvirt
root_helper=sudo nova-rootwrap /etc/nova/rootwrap.conf
verbose=True
rpc_backend = nova.rpc.impl_kombu
rabbit_host = 127.0.0.1
rabbit_password = rabbit
my_ip = 127.0.0.1
vncserver_listen = 127.0.0.1
vncserver_proxyclient_address = 127.0.0.1
novncproxy_base_url=http://127.0.0.1:6080/vnc_auto.html
glance_host = 127.0.0.1
auth_strategy=keystone

network_api_class=nova.network.neutronv2.api.API
neutron_url=http://127.0.0.1:9696
neutron_auth_strategy=keystone
neutron_admin_tenant_name=service
neutron_admin_username=neutron
neutron_admin_password=neutron_pass
neutron_metadata_proxy_shared_secret=openstack
neutron_admin_auth_url=http://127.0.0.1:35357/v2.0
linuxnet_interface_driver = nova.network.linux_net.LinuxOVSInterfaceDriver
firewall_driver=nova.virt.firewall.NoopFirewallDriver
security_group_api=neutron

vif_plugging_is_fatal: false
vif_plugging_timeout: 0

[database]
connection = mysql://nova:nova_dbpass@127.0.0.1/nova

[keystone_authtoken]
auth_uri = http://127.0.0.1:5000
auth_host = 127.0.0.1
auth_port = 35357
auth_protocol = http
admin_tenant_name = service
admin_user = nova
admin_password = nova_pass
sync the Nova db
"

nova-manage db sync


echo "Restart all nova services
"

echo "^C to break, any key to continue....";read readline

service nova-api restart ;service nova-cert restart; service nova-consoleauth restart ;service nova-scheduler restart;service nova-conductor restart; service nova-novncproxy restart; service nova-compute restart; service nova-console restart
echo "Test the Nova installation using the following command

nova-manage service list
i"

echo "^C to break, any key to continue....";read readline

echo "^C to break, any key to continue....";read readline

echo "The output should be something like this

Binary           Host                     Zone             Status     State Updated_At
nova-consoleauth ubuntu                   internal         enabled    :-)   2014-04-19 08:55:13
nova-conductor   ubuntu                   internal         enabled    :-)   2014-04-19 08:55:14
nova-cert        ubuntu                   internal         enabled    :-)   2014-04-19 08:55:13
nova-scheduler   ubuntu                   internal         enabled    :-)   2014-04-19 08:55:13
nova-compute     ubuntu                   nova             enabled    :-)   2014-04-19 08:55:14
nova-console     ubuntu                   internal         enabled    :-)   2014-04-19 08:55:14
Also run the following command to check if nova is able to authenticate with keystone server
"

echo "^C to break, any key to continue....";read readline

nova list

echo "Neutron(Networking service)

Install the Neutron services
"


echo "^C to break, any key to continue....";read readline

apt-get install -y neutron-server neutron-plugin-openvswitch neutron-plugin-openvswitch-agent neutron-common neutron-dhcp-agent neutron-l3-agent neutron-metadata-agent openvswitch-switch
Create database and credentials for Neutron

mysql -u root -p

echo "
CREATE DATABASE neutron;
GRANT ALL ON neutron.* TO 'neutron'@'%' IDENTIFIED BY 'neutron_dbpass';
quit;
Create Keystone entries for Neutron
"

echo "^C to break, any key to continue....";read readline

keystone user-create --name=neutron --pass=neutron_pass --email=neutron@example.com
keystone service-create --name=neutron --type=network --description="OpenStack Networking"
keystone user-role-add --user=neutron --tenant=service --role=admin
keystone endpoint-create --service=neutron --publicurl http://127.0.0.1:9696 --adminurl http://127.0.0.1:9696  --internalurl http://127.0.0.1:9696

echo "
Edit /etc/neutron/neutron.conf
[DEFAULT]
core_plugin = ml2
notification_driver=neutron.openstack.common.notifier.rpc_notifier
verbose=True
rpc_backend = rabbit
rabbit_host = 127.0.0.1
rabbit_password = rabbit
service_plugins=router
allow_overlapping_ips=True
auth_strategy=keystone
neutron_metadata_proxy_shared_secret=openstack
service_neutron_metadata_proxy=True
nova_admin_password=nova_pass
notify_nova_on_port_data_changes=True
notify_nova_on_port_status_changes=True
nova_admin_auth_url=http://127.0.0.1:35357/v2.0
nova_admin_tenant_id=service
nova_url=http://127.0.0.1:8774/v2
nova_admin_username=nova


[keystone_authtoken]
auth_host = 127.0.0.1
auth_port = 35357
auth_protocol = http
admin_tenant_name = service
admin_user = neutron
admin_password = neutron_pass
signing_dir = $state_path/keystone-signing

notify_nova_on_port_status_changes = True
notify_nova_on_port_data_changes = True
nova_url = http://127.0.0.1:8774
nova_admin_username = nova
nova_admin_tenant_id =
nova_admin_password = nova_pass
nova_admin_auth_url = http://127.0.0.1:35357/v2.0

[database]
connection = mysql://neutron:neutron_dbpass@127.0.0.1/neutron

[agent]
root_helper = sudo /usr/bin/neutron-rootwrap /etc/neutron/rootwrap.conf
Open /etc/neutron/plugins/ml2/ml2_conf.ini and make the following changes

[ml2]
type_drivers=flat,vlan
tenant_network_types=vlan,flat
mechanism_drivers=openvswitch
[ml2_type_flat]
flat_networks=External
[ml2_type_vlan]
network_vlan_ranges=Intnet1:100:200
[ml2_type_gre]
[ml2_type_vxlan]
[securitygroup]
firewall_driver=neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver
enable_security_group=True
[ovs]
bridge_mappings=External:br-ex,Intnet1:br-eth1
We have created two physical networks one as a flat network and the other as a vlan network with vlan ranging from 100 to 200. We have mapped External network to br-ex and Intnet1 to br-eth1. Now Create bridges

ovs-vsctl add-br br-int
ovs-vsctl add-br br-eth1
ovs-vsctl add-br br-ex
ovs-vsctl add-port br-eth1 eth1
ovs-vsctl add-port br-ex eth2
According to our set up all traffic belonging to External network will be bridged to eth2 and all traffic of Intnet1 will be bridged to eth1. If you have only one interface(eth0) and would like to use it for all networking then please have a look at https://fosskb.wordpress.com/2014/06/10/managing-openstack-internaldataexternal-network-in-one-interface.
"

echo "^C to break, any key to continue....";read readline
echo "Edit /etc/neutron/metadata_agent.ini to look like this

[DEFAULT]
auth_url = http://127.0.0.1:5000/v2.0
auth_region = RegionOne
admin_tenant_name = service
admin_user = neutron
admin_password = neutron_pass
metadata_proxy_shared_secret = openstack
Edit /etc/neutron/dhcp_agent.ini to look like this

[DEFAULT]
interface_driver = neutron.agent.linux.interface.OVSInterfaceDriver
dhcp_driver = neutron.agent.linux.dhcp.Dnsmasq
use_namespaces = True
Edit /etc/neutron/l3_agent.ini to look like this

[DEFAULT]
interface_driver = neutron.agent.linux.interface.OVSInterfaceDriver
use_namespaces = True
Sync the db
"
neutron-db-manage --config-file /etc/neutron/neutron.conf --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade juno
Restart all Neutron services

service neutron-server restart; service neutron-plugin-openvswitch-agent restart;service neutron-metadata-agent restart; service neutron-dhcp-agent restart; service neutron-l3-agent restart
echo "Check if the services are running. Run the following command
"
neutron agent-list
echo "The output should be like

+--------------------------------------+--------------------+--------+-------+----------------+
| id                                   | agent_type         | host   | alive | admin_state_up |
+--------------------------------------+--------------------+--------+-------+----------------+
| 01a5e70c-324a-4183-9652-6cc0e5c98499 | Metadata agent     | ubuntu | :-)   | True           |
| 17b9440b-50eb-48b7-80a8-a5bbabc47805 | DHCP agent         | ubuntu | :-)   | True           |
| c30869f2-aaca-4118-829d-a28c63a27aa4 | L3 agent           | ubuntu | :-)   | True           |
| f846440e-4ca6-4120-abe1-ffddaf1ab555 | Open vSwitch agent | ubuntu | :-)   | True           |
+--------------------------------------+--------------------+--------+-------+----------------+
Users who want to know what happens under the hood can read

How neutron-openvswitch-agent provides L2 connectivity between Instances, DHCP servers and routers
How neutron-l3-agent provides services like routing, natting, floatingIP and security groups
See more of Linux networking capabilitie
"

echo "^C to break, any key to continue....";read readline

echo "s
Cinder

Install Cinder services
"
apt-get install cinder-api cinder-scheduler cinder-volume lvm2 open-iscsi-utils open-iscsi iscsitarget sysfsutils
echo "Create database and credentials for Cinder

mysql -u root -p
mysql> CREATE DATABASE cinder;
mysql> GRANT ALL PRIVILEGES ON cinder.* TO 'cinder'@'%' IDENTIFIED BY 'cinder_dbpass';
quit;
Create Cinder related keystone entries
"

echo "^C to break, any key to continue....";read readline

keystone user-create --name=cinder --pass=cinder_pass --email=cinder@example.com
keystone user-role-add --user=cinder --tenant=service --role=admin
keystone service-create --name=cinder --type=volume --description="OpenStack Block Storage"
keystone endpoint-create --service=cinder --publicurl=http://127.0.0.1:8776/v1/%\(tenant_id\)s --internalurl=http://127.0.0.1:8776/v1/%\(tenant_id\)s --adminurl=http://127.0.0.1:8776/v1/%\(tenant_id\)s
keystone service-create --name=cinderv2 --type=volumev2 --description="OpenStack Block Storage v2"
keystone endpoint-create --service=cinderv2 --publicurl=http://127.0.0.1:8776/v2/%\(tenant_id\)s --internalurl=http://127.0.0.1:8776/v2/%\(tenant_id\)s --adminurl=http://127.0.0.1:8776/v2/%\(tenant_id\)

echo "

Edit /etc/cinder/cinder.conf and replace all the lines with the following.

[DEFAULT]
rootwrap_config = /etc/cinder/rootwrap.conf
api_paste_confg = /etc/cinder/api-paste.ini
iscsi_helper = tgtadm
volume_name_template = volume-%s
volume_group = cinder-volumes
verbose = True
auth_strategy = keystone
state_path = /var/lib/cinder
lock_path = /var/lock/cinder
volumes_dir = /var/lib/cinder/volumes
rpc_backend = cinder.openstack.common.rpc.impl_kombu
rabbit_host = 127.0.0.1
rabbit_port = 5672
rabbit_userid = guest
rabbit_password = rabbit
glance_host = 127.0.0.1

[database]
connection = mysql://cinder:cinder_dbpass@127.0.0.1/cinder

[keystone_authtoken]
auth_uri = http://127.0.0.1:5000
auth_host = 127.0.0.1
auth_port = 35357
auth_protocol = http
admin_tenant_name = service
admin_user = cinder
admin_password = cinder_pass
Sync the database
"

cinder-manage db sync
echo "Create physical volume
"
pvcreate /dev/sdb


echo "^C to break, any key to continue....";read readline
echo "#Create volume group named “cinder-volumes”
"
vgcreate cinder-volumes /dev/sdb
echo "Restart all the Cinder services
"
service cinder-scheduler restart;service cinder-api restart;service cinder-volume restart;service tgt restart

echo "
Create a volume to test the setup
"
cinder create --display-name myVolume 1
echo "List the volume created

cinder list
+--------------------------------------+-----------+--------------+------+-------------+----------+-------------+
|                  ID                  |   Status  | Display Name | Size | Volume Type | Bootable | Attached to |
+--------------------------------------+-----------+--------------+------+-------------+----------+-------------+
| e19242b5-8caf-4093-9b81-96d6bb1f7000 | available |   myVolume   |  1   |     None    |  false   |             |
+--------------------------------------+-----------+--------------+------+-------------+----------+-------------+
Horizon (OpenStack Dashboard)
"

echo "^C to break, any key to continue....";read readline

apt-get install -y openstack-dashboard

echo "
After installing login using the following credentials

URL     : http://127.0.0.1/horizon
Username: admin
Password: ADMIN
For an automated OpenStack install, please check OpenStack using SaltStack.

About these ads

Share this:
4Click to share on Twitter8Share on FacebookClick to email this to a friendClick to print4Click to share on LinkedInClick to share on RedditClick to share on StumbleUponClick to share on Google+Click to share on TumblrClick to share on PinterestClick to share on Pocket

Related
OpenStack IceHouse on Ubuntu 14.04 LTS and 12.04 LTS - Single machine setup
In "Cloud"
OpenStack Havana on Ubuntu 12.04 LTS - Single machine setup
In "Cloud"
OpenStack Icehouse on Debian Wheezy - Single Machine setup
In "Cloud"
18/10/2014Johnson D  DIY, OpenStack Juno Guide, OpenStack Juno Installation Guide
Post navigation← OpenStack Beginner’s Guide – For Ubuntu TrustyOpenStack Automated Install →
10 thoughts on “OpenStack Juno on Ubuntu 14.10 – Single Machine Setup”
Anshuman says:
25/01/2015 at 9:50 AM
Hi, this is an amazing tutorial. I have been running devtsack for over a year now but finally understood each component to get openstack working. Now, everything works except for the networking. I can get instances up but can’t ping or ssh into them. My IP was 192.168.1.219 instead of the 10.X.X.X that you used. I see that the host machine has a new virbr0 interface 192.168.122.1. However, the VMs that are launching have an eth0 interface having only IPv6 addresses. I have created two networks with addresses 192.168.1.0/24 and 192.168.122.0/24. VMs launched in both networks seem to be unreachable.

Reply
Jamie says:
12/01/2015 at 7:06 PM
I followed your install, everything went smooth, but I got stuck with creating instances. I create a new instance from Cirros image, but it fails on creating an image for the instance. Could you help me to fix it?

/var/log/nova/nova-compute.log:

2015-01-12 16:33:02.539 2551 AUDIT nova.compute.manager [req-84b2e749-b27a-4acb-be60-5f1818e453f2 None] [instance: aafe3871-ff5c-4416-9261-d72faaeac107] Starting instance…
2015-01-12 16:33:02.763 2551 AUDIT nova.compute.claims [-] [instance: aafe3871-ff5c-4416-9261-d72faaeac107] Attempting claim: memory 512 MB, disk 1 GB
2015-01-12 16:33:02.764 2551 AUDIT nova.compute.claims [-] [instance: aafe3871-ff5c-4416-9261-d72faaeac107] Total memory: 16015 MB, used: 512.00 MB
2015-01-12 16:33:02.764 2551 AUDIT nova.compute.claims [-] [instance: aafe3871-ff5c-4416-9261-d72faaeac107] memory limit: 24022.50 MB, free: 23510.50 MB
2015-01-12 16:33:02.764 2551 AUDIT nova.compute.claims [-] [instance: aafe3871-ff5c-4416-9261-d72faaeac107] Total disk: 492 GB, used: 0.00 GB
2015-01-12 16:33:02.765 2551 AUDIT nova.compute.claims [-] [instance: aafe3871-ff5c-4416-9261-d72faaeac107] disk limit not specified, defaulting to unlimited
2015-01-12 16:33:02.773 2551 AUDIT nova.compute.claims [-] [instance: aafe3871-ff5c-4416-9261-d72faaeac107] Claim successful
2015-01-12 16:33:02.967 2551 INFO nova.scheduler.client.report [-] Compute_service record updated for (‘test-cluster’, ‘test-cluster’)
2015-01-12 16:33:03.242 2551 INFO nova.scheduler.client.report [-] Compute_service record updated for (‘test-cluster’, ‘test-cluster’)
2015-01-12 16:33:04.092 2551 INFO nova.virt.libvirt.driver [-] [instance: aafe3871-ff5c-4416-9261-d72faaeac107] Creating image
2015-01-12 16:33:04.167 2551 INFO nova.scheduler.client.report [-] Compute_service record updated for (‘test-cluster’, ‘test-cluster’)
2015-01-12 16:33:04.814 2551 INFO nova.virt.disk.vfs.api [-] Unable to import guestfsfalling back to VFSLocalFS
2015-01-12 16:33:05.205 2551 ERROR nova.compute.manager [-] [instance: aafe3871-ff5c-4416-9261-d72faaeac107] Instance failed to spawn
2015-01-12 16:33:05.205 2551 TRACE nova.compute.manager [instance: aafe3871-ff5c-4416-9261-d72faaeac107] Traceback (most recent call last):
2015-01-12 16:33:05.205 2551 TRACE nova.compute.manager [instance: aafe3871-ff5c-4416-9261-d72faaeac107] File “/usr/lib/python2.7/dist-packages/nova/compute/manager.py”, line 2249, in _build_resources
2015-01-12 16:33:05.205 2551 TRACE nova.compute.manager [instance: aafe3871-ff5c-4416-9261-d72faaeac107] yield resources
2015-01-12 16:33:05.205 2551 TRACE nova.compute.manager [instance: aafe3871-ff5c-4416-9261-d72faaeac107] File “/usr/lib/python2.7/dist-packages/nova/compute/manager.py”, line 2119, in _build_and_run_instance
2015-01-12 16:33:05.205 2551 TRACE nova.compute.manager [instance: aafe3871-ff5c-4416-9261-d72faaeac107] block_device_info=block_device_info)
2015-01-12 16:33:05.205 2551 TRACE nova.compute.manager [instance: aafe3871-ff5c-4416-9261-d72faaeac107] File “/usr/lib/python2.7/dist-packages/nova/virt/libvirt/driver.py”, line 2619, in spawn
2015-01-12 16:33:05.205 2551 TRACE nova.compute.manager [instance: aafe3871-ff5c-4416-9261-d72faaeac107] write_to_disk=True)
2015-01-12 16:33:05.205 2551 TRACE nova.compute.manager [instance: aafe3871-ff5c-4416-9261-d72faaeac107] File “/usr/lib/python2.7/dist-packages/nova/virt/libvirt/driver.py”, line 4150, in _get_guest_xml
2015-01-12 16:33:05.205 2551 TRACE nova.compute.manager [instance: aafe3871-ff5c-4416-9261-d72faaeac107] context)
2015-01-12 16:33:05.205 2551 TRACE nova.compute.manager [instance: aafe3871-ff5c-4416-9261-d72faaeac107] File “/usr/lib/python2.7/dist-packages/nova/virt/libvirt/driver.py”, line 3936, in _get_guest_config
2015-01-12 16:33:05.205 2551 TRACE nova.compute.manager [instance: aafe3871-ff5c-4416-9261-d72faaeac107] flavor, CONF.libvirt.virt_type)
2015-01-12 16:33:05.205 2551 TRACE nova.compute.manager [instance: aafe3871-ff5c-4416-9261-d72faaeac107] File “/usr/lib/python2.7/dist-packages/nova/virt/libvirt/vif.py”, line 352, in get_config
2015-01-12 16:33:05.205 2551 TRACE nova.compute.manager [instance: aafe3871-ff5c-4416-9261-d72faaeac107] _(“Unexpected vif_type=%s”) % vif_type)
2015-01-12 16:33:05.205 2551 TRACE nova.compute.manager [instance: aafe3871-ff5c-4416-9261-d72faaeac107] NovaException: Unexpected vif_type=binding_failed
2015-01-12 16:33:05.205 2551 TRACE nova.compute.manager [instance: aafe3871-ff5c-4416-9261-d72faaeac107]
2015-01-12 16:33:05.207 2551 AUDIT nova.compute.manager [req-84b2e749-b27a-4acb-be60-5f1818e453f2 None] [instance: aafe3871-ff5c-4416-9261-d72faaeac107] Terminating instance
2015-01-12 16:33:05.211 2551 WARNING nova.virt.libvirt.driver [-] [instance: aafe3871-ff5c-4416-9261-d72faaeac107] During wait destroy, instance disappeared.
2015-01-12 16:33:05.317 2551 INFO nova.virt.libvirt.driver [-] [instance: aafe3871-ff5c-4416-9261-d72faaeac107] Deleting instance files /var/lib/nova/instances/aafe3871-ff5c-4416-9261-d72faaeac107_del
2015-01-12 16:33:05.318 2551 INFO nova.virt.libvirt.driver [-] [instance: aafe3871-ff5c-4416-9261-d72faaeac107] Deletion of /var/lib/nova/instances/aafe3871-ff5c-4416-9261-d72faaeac107_del complete
2015-01-12 16:33:05.556 2551 INFO nova.scheduler.client.report [-] Compute_service record updated for (‘test-cluster’, ‘test-cluster’)

Reply
Juan Antonio Pérez Cantero says:
18/12/2014 at 8:34 AM
Hi i’m trying this and glance’s section i get the following:

root@openstack:~# glance image-create –name Cirros –is-public true –container-format bare –disk-format qcow2 –location https://launchpad.net/cirros/trunk/0.3.0/+download/cirros-0.3.0-x86_64-disk.img
Request returned failure status.
Invalid OpenStack Identity credentials.

help me please, thanks!

Reply
Jamie says:
12/01/2015 at 8:06 PM
you need to make sure you have correctly specified glance service password in /etc/glance/glance-api.conf. It should be the same as in “keystone user-create …”

Reply
Anshuman says:
25/01/2015 at 9:26 AM
I was getting the same error. It was because I didn’t use the latest version of Juno from the Ubuntu ppa. A bug was raised here: https://bugs.launchpad.net/openstack-manuals/+bug/1362521.
“apt-get install python-software-properties”
“add-apt-repository cloud-archive:juno”
“apt-get update && apt-get dist-upgrade”
Solved it for me.

Reply
rihatum says:
28/11/2014 at 3:17 PM
Hi JohnsonD,

Thank you for the how-to, I am going to try this soon. just one question, how would we add the hypervisors? in my case I have a physical box running xen server and another box running esx. I want to add my xen box to this controller – will be grateful if you could share the procedure / requirements – thanks

kind regards

Reply
Gary Day says:
24/11/2014 at 6:30 PM
I tried this (and the install guide from docs.openstack) and there is a problem with Glance, it seems that you get a http error (HTTP 500), npt sure why, seems keystone is working OK, but glance has issues; I have de-installed and re-installed and re-provisioned glance with no joy… Any ideas ? :)

Reply
Joe says:
08/11/2014 at 9:57 AM
Attaching cinder volumes in 14.10 is broken along with many others things. (systemd.. etc..
) 14.10 was just slapped together. Very poor inexcusable job Cannonical..

Reply
Frank says:
24/10/2014 at 6:16 AM
You might want to include the packages for Juno

Reply
Johnson D says:
24/10/2014 at 8:34 AM
We need not add packages for Juno in Ubuntu 14.10, as this version of Ubuntu is bundled with Juno packages by default. We need to add Juno repository only if it is any other older version of Ubuntu.

Reply
Leave a Reply


Search FOSSKB

Search
  Akilesh
  Johnson D
  naviensubramani
  eternaltyro
Blogs I Follow

VIETSTACK
Pinlabs Blog
Kiran Murari
Technology Consulting, Software Architecture Services around Cloud, Mobile and Internet of Things - Qruize Blog
appdevexpress
Coffee Breaks
Railway Junction Blog
vivek raghuwanshi
SIA Photography
...in search of that perfect world.
Chennai Focus - A Tabloid on Chennai
Free and Open Source Software Knowledge Base
Going GNU
Qruize Technologies
Good local Food
John Vagabond's Physics and Chemistry Blog
fame game!
nadavu@wordpress.com
October 2014
S	M	T	W	T	F	S
« Sep	 	Nov »
 	1	2	3	4
5	6	7	8	9	10	11
12	13	14	15	16	17	18
19	20	21	22	23	24	25
26	27	28	29	30	31	 
Blog Stats

85,681 hits
Categories


Apache Apache 2.4 BSD Cloud Debian FAMP Fedora FreeBSD FreeBSD 10.0 Grizzly Havana IceHouse Image Management Juno Keystone Linux Distribution Network Management Neutron OpenFlow Open source OpenStack OpenStack architecture OpenStack installation guide Open vSwitch Quantum Software Defined Networking Ubuntu Uncategorized Virtualization Web Server
Top Posts & Pages

OpenStack Juno on Ubuntu 14.10 - Single Machine Setup
Managing Openstack Internal/Data/External network in one interface
OpenStack IceHouse on Ubuntu 14.04 LTS and 12.04 LTS - Single machine setup
FAMP - Installing Apache2.4, MySQL, PHP on FreeBSD 10
Installing Mate desktop on FreeBSD-10
Installing Gnome on FreeBSD-10
L2 connectivity in OpenStack using OpenvSwitch mechanism driver
L3 connectivity using neutron-l3-agent
OpenStack Icehouse on Debian Wheezy - Single Machine setup
OpenStack Automated Install
Follow Blog via Email

Enter your email address to follow this blog and receive notifications of new posts by email.

Join 88 other followers





Tags

AD Apache Pig Installation authentication Building a customized kernel in FreeBSD10.0 Debian on OpenStack Desktop on FreeBSD DIY Django on FreeBSD FAMP server FreeBSD 9.1 Server in cloud FreeBSD Jail Guide FreeBSD on Raspberry Pi Games for Linux Gnome on FreeBSD GUI on FreeBSD GUI on FreeBSD 10 Hadoop Ecosystem Installation Hadoop Installation Guide Hadoop installation guide for Beginners Hadoop multi node setup Hbase Installation Hive Installation IAM Jails on FreeBSD10 LDAP Linux Containers LXC Managing FreeBSD jails Mate on FreeBSD 10 OpenDaylight OpenLDAP Open Source Open Source Astronomy application Open Source Games OpenStack Beginner's Guide OpenStack Debian Instance OpenStack FreeBSD image OpenStack Grizzly Guide OpenStack Havana Guide OpenStack IceHouse guide OpenStack IceHouse on Ubuntu12.04 OpenStack IceHouse on Ubuntu14.04 OpenStack Juno OpenStack Juno Guide OpenStack Juno Installation Guide OpenStack on Debian guide OpenStack on FreeBSD OpenStack Quantum control flow Open vSwitch slapd Spark Installation Sqoop Installation SSH tunneling Stellarium Beginner's guide Stellarium doc Stellarium Guide Virtual Planetarium Yarn Installation
Top Clicks

zcentric.com/2014/07/07/o…
fosskb.wordpress.com/2014…
akilesh1597.github.io/sal…
fosskb.files.wordpress.co…
railwayjunction.wordpress…
dropbox.com/s/xpscchu7hgm…
help.github.com/articles/…
fosskb.files.wordpress.co…
docs.saltstack.com/en/lat…
blog.pinlabs.in/?p=2851
Blog at WordPress.com. ~ The Syntax Theme.
Follow
Follow “Free and Open Source Software Knowledge Base”

Get every new post delivered to your Inbox.

Join 88 other followers

"


echo "^C to break, any key to continue....";read readline





