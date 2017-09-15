#/home/vhuang/bin/install_all_openstack.sh
 sudo apt-get install -y --force-yes mysql-server

 sudo apt-get install -y --force-yes libmysqlclient-dev #- MySQL database development files
 sudo apt-get install -y --force-yes mysql-client #- MySQL database client (metapackage depending on the latest version)

#^Cvhuang@vhuang-v114:/sda1/gscraper-2015-01-07-14-12-25$ aptseek.sh openstack|grep -i OpenStack
 sudo apt-get install -y --force-yes glance #- OpenStack Image Registry and Delivery Service #- Daemons
 sudo apt-get install -y --force-yes glance-api #- OpenStack Image Registry and Delivery Service #- API
 sudo apt-get install -y --force-yes glance-common #- OpenStack Image Registry and Delivery Service #- Common
 sudo apt-get install -y --force-yes glance-registry #- OpenStack Image Registry and Delivery Service #- Registry
 sudo apt-get install -y --force-yes heat-api #- OpenStack orchestration service #- ReST API
 sudo apt-get install -y --force-yes heat-api-cfn #- OpenStack orchestration service #- CFN API
 sudo apt-get install -y --force-yes heat-api-cloudwatch #- OpenStack orchestration service #- CloudWatch API
 sudo apt-get install -y --force-yes heat-common #- OpenStack orchestration service #- common files
 sudo apt-get install -y --force-yes heat-engine #- OpenStack orchestration service #- engine
 sudo apt-get install -y --force-yes keystone #- OpenStack identity service #- Daemons
 sudo apt-get install -y --force-yes keystone-doc #- OpenStack identity service #- Documentation
 sudo apt-get install -y --force-yes neutron-common #- Neutron is a virtual network service for Openstack #- common
 sudo apt-get install -y --force-yes neutron-dhcp-agent #- Neutron is a virtual network service for Openstack #- DHCP agent
 sudo apt-get install -y --force-yes neutron-l3-agent #- Neutron is a virtual network service for Openstack #- l3 agent
 sudo apt-get install -y --force-yes neutron-lbaas-agent #- Neutron is a virtual network service for Openstack #- LBaaS agent
 sudo apt-get install -y --force-yes neutron-metadata-agent #- Neutron is a virtual network service for Openstack #- metadata agent
 sudo apt-get install -y --force-yes neutron-plugin-cisco #- Neutron is a virtual network service for Openstack #- Cisco plugin
 sudo apt-get install -y --force-yes neutron-plugin-linuxbridge #- Neutron is a virtual network service for Openstack #- linuxbridge plugin
 sudo apt-get install -y --force-yes neutron-plugin-linuxbridge-agent #- Neutron is a virtual network service for Openstack #- linuxbridge plugin agent
 sudo apt-get install -y --force-yes neutron-plugin-metaplugin #- Neutron is a virtual network service for Openstack #- Metaplugin plugin
 sudo apt-get install -y --force-yes neutron-plugin-midonet #- Neutron is a virtual network service for Openstack #- Midonet plugin
 sudo apt-get install -y --force-yes neutron-plugin-ml2 #- Neutron is a virtual network service for Openstack #- ML2 plugin
 sudo apt-get install -y --force-yes neutron-plugin-nec #- Neutron is a virtual network service for Openstack #- NEC plugin
 sudo apt-get install -y --force-yes neutron-plugin-openvswitch #- Neutron is a virtual network service for Openstack #- Open vSwitch plugin
 sudo apt-get install -y --force-yes neutron-plugin-openvswitch-agent #- Neutron is a virtual network service for Openstack #- Open vSwitch plugin agent
 sudo apt-get install -y --force-yes neutron-plugin-ryu #- Neutron is a virtual network service for Openstack #- RYU plugin
 sudo apt-get install -y --force-yes neutron-plugin-ryu-agent #- Neutron is a virtual network service for Openstack #- RYU plugin agent
 sudo apt-get install -y --force-yes neutron-plugin-vmware #- Neutron is a virtual network service for Openstack #- VMware plugin
 sudo apt-get install -y --force-yes neutron-server #- Neutron is a virtual network service for Openstack #- server
 sudo apt-get install -y --force-yes nova-api #- OpenStack Compute #- API frontend
 sudo apt-get install -y --force-yes nova-cert #- OpenStack Compute #- certificate management
 sudo apt-get install -y --force-yes nova-common #- OpenStack Compute #- common files
 sudo apt-get install -y --force-yes nova-compute #- OpenStack Compute #- compute node base
 sudo apt-get install -y --force-yes nova-compute-kvm #- OpenStack Compute #- compute node (KVM)
 sudo apt-get install -y --force-yes nova-compute-libvirt #- OpenStack Compute #- compute node libvirt support
 sudo apt-get install -y --force-yes nova-compute-lxc #- OpenStack Compute #- compute node (LXC)
 sudo apt-get install -y --force-yes nova-doc #- OpenStack Compute #- documentation
 sudo apt-get install -y --force-yes nova-network #- OpenStack Compute #- Network manager
 sudo apt-get install -y --force-yes nova-objectstore #- OpenStack Compute #- object store
 sudo apt-get install -y --force-yes nova-scheduler #- OpenStack Compute #- virtual machine scheduler
 sudo apt-get install -y --force-yes nova-volume #- OpenStack Compute #- storage
 sudo apt-get install -y --force-yes openstack-dashboard #- Django web interface for OpenStack
 sudo apt-get install -y --force-yes openstack-dashboard-ubuntu-theme #- Ubuntu theme for the OpenStack dashboard
 sudo apt-get install -y --force-yes openstack-pkg-tools #- Tools and scripts for building Openstack packages in Debian
 sudo apt-get install -y --force-yes python-barbicanclient #- OpenStack Key Management API client #- Python 2.x
 sudo apt-get install -y --force-yes python-ceilometerclient #- Client library for Openstack ceilometer server.
 sudo apt-get install -y --force-yes python-cinderclient #- python bindings to the OpenStack Volume API
 sudo apt-get install -y --force-yes python-django-horizon #- Django module providing web based interaction with OpenStack
 sudo apt-get install -y --force-yes python-glance #- OpenStack Image Registry and Delivery Service #- Python library
 sudo apt-get install -y --force-yes python-glance-doc #- OpenStack Image Registry and Delivery Service #- Documentation
 sudo apt-get install -y --force-yes python-glance-store #- OpenStack Image Service store library #- Python 2.x
 sudo apt-get install -y --force-yes python-glance-store-doc #- OpenStack Image Service store library #- doc
 sudo apt-get install -y --force-yes python-glanceclient #- Client library for Openstack glance server.
 sudo apt-get install -y --force-yes python-hacking #- Flake8 OpenStack Hacking Guidelines Enforcement plugins #- Python 2.x
 sudo apt-get install -y --force-yes python-hacking-doc #- Flake8 OpenStack Hacking Guidelines Enforcement plugins #- doc
 sudo apt-get install -y --force-yes python-heat #- OpenStack orchestration service #- Python files
 sudo apt-get install -y --force-yes python-heatclient #- client library and CLI for OpenStack Heat
 sudo apt-get install -y --force-yes python-ironicclient #- Client for OpenStack bare metal Service
 sudo apt-get install -y --force-yes python-keystone #- OpenStack identity service #- Python library
 sudo apt-get install -y --force-yes python-keystoneclient #- Client library for OpenStack Identity API
 sudo apt-get install -y --force-yes python-keystonemiddleware #- Middleware for OpenStack Identity (Keystone) #- Python 2.x
 sudo apt-get install -y --force-yes python-keystonemiddleware-doc #- Middleware for OpenStack Identity (Keystone) #- doc
 sudo apt-get install -y --force-yes python-neutron #- Neutron is a virutal network service for Openstack #- Python library
 sudo apt-get install -y --force-yes python-neutronclient #- client #- Neutron is a virtual network service for Openstack
 sudo apt-get install -y --force-yes python-nova #- OpenStack Compute Python libraries
 sudo apt-get install -y --force-yes python-novaclient #- client library for OpenStack Compute API
 sudo apt-get install -y --force-yes python-openstack-auth #- Django authentication backend for Openstack
 sudo apt-get install -y --force-yes python-oslo.config #- Common code for Openstack Projects (configuration API) #- Python 2.x
 sudo apt-get install -y --force-yes python-oslo.config-doc #- Common code for Openstack Projects (configuration API) #- doc
 sudo apt-get install -y --force-yes python-oslo.sphinx #- theme and extension support for openstack #- transition package
 sudo apt-get install -y --force-yes python-oslo.utils #- set of utility functions for OpenStack #- Python 2.x
 sudo apt-get install -y --force-yes python-oslo.vmware #- VMware library for OpenStack projects #- Python 2.x
 sudo apt-get install -y --force-yes python-oslo.vmware-doc #- VMware library for OpenStack projects #- doc
 sudo apt-get install -y --force-yes python-oslosphinx #- theme and extension support for openstack
 sudo apt-get install -y --force-yes python-oslotest #- OpenStack test framework #- Python 2.x
 sudo apt-get install -y --force-yes python-oslotest-doc #- OpenStack test framework #- doc
 sudo apt-get install -y --force-yes python-osprofiler #- OSProfiler is an OpenStack cross-project profiling library
 sudo apt-get install -y --force-yes python-saharaclient #- Client library for Openstack Sahara API server #- Python 2.x module
 sudo apt-get install -y --force-yes python-saharaclient-doc #- Client library for Openstack Sahara API server #- documentation
 sudo apt-get install -y --force-yes python-swiftclient #- Client library for Openstack Swift API.
 sudo apt-get install -y --force-yes python-troveclient #- Client library for Openstack Trove API.
 sudo apt-get install -y --force-yes python3-oslo.config #- Common code for Openstack Projects (configuration API) #- Python 3.x
 sudo apt-get install -y --force-yes python3-oslo.utils #- set of utility functions for OpenStack #- Python 3.x
 sudo apt-get install -y --force-yes python3-oslotest #- OpenStack test framework #- Python 3.x
 sudo apt-get install -y --force-yes designate #- OpenStack DNS as a Service #- metapackage
 sudo apt-get install -y --force-yes designate-agent #- OpenStack DNS as a Service #- agent
 sudo apt-get install -y --force-yes designate-api #- OpenStack DNS as a Service #- API server
 sudo apt-get install -y --force-yes designate-central #- OpenStack DNS as a Service #- central daemon
 sudo apt-get install -y --force-yes designate-common #- OpenStack DNS as a Service #- common files
 sudo apt-get install -y --force-yes designate-doc #- OpenStack DNS as a Service #- doc
 sudo apt-get install -y --force-yes designate-sink #- OpenStack DNS as a Service #- sink
 sudo apt-get install -y --force-yes ftp-cloudfs #- FTP interface to Rackspace Cloud Files and OpenStack Object Storage
 sudo apt-get install -y --force-yes ironic-api #- Openstack bare metal provisioning service #- API
 sudo apt-get install -y --force-yes ironic-common #- Openstack bare metal provisioning service #- daemons
 sudo apt-get install -y --force-yes ironic-conductor #- Openstack bare metal provisioning service #- conductor
 sudo apt-get install -y --force-yes munin-plugins-openstack #- Plugins for Munin compatible monitoring OpenStack based systems
 sudo apt-get install -y --force-yes nagios-plugins-openstack #- Plugins for nagios compatible monitoring OpenStack based systems
 sudo apt-get install -y --force-yes neutron-metering-agent #- Neutron is a virtual network service for Openstack #- metering agent
 sudo apt-get install -y --force-yes neutron-plugin-bigswitch #- Neutron is a virtual network service for Openstack #- BigSwitch plugin
 sudo apt-get install -y --force-yes neutron-plugin-bigswitch-agent #- Neutron is a virtual network service for Openstack #- BigSwitch plugin agent
 sudo apt-get install -y --force-yes neutron-plugin-brocade #- Neutron is a virtual network service for Openstack #- Brocade plugin
 sudo apt-get install -y --force-yes neutron-plugin-hyperv #- Neutron is a virtual network service for Openstack #- Hyper-V plugin
 sudo apt-get install -y --force-yes neutron-plugin-ibm #- Neutron is a virtual network service for Openstack #- IBM SDN plugin
 sudo apt-get install -y --force-yes neutron-plugin-ibm-agent #- Neutron is a virtual network service for Openstack #- IBM agent
 sudo apt-get install -y --force-yes neutron-plugin-mlnx #- Neutron is a virtual network service for Openstack #- Mellanox plugin
 sudo apt-get install -y --force-yes neutron-plugin-mlnx-agent #- Neutron is a virtual network service for Openstack #- Mellanox plugin agent
 sudo apt-get install -y --force-yes neutron-plugin-nec-agent #- Neutron is a virtual network service for Openstack #- NEC plugin agent
 sudo apt-get install -y --force-yes neutron-plugin-nuage #- Neutron is a virtual network service for Openstack #- Nuage plugin
 sudo apt-get install -y --force-yes neutron-plugin-oneconvergence #- Neutron is a virtual network service for Openstack #- One Convergence plugin
 sudo apt-get install -y --force-yes neutron-plugin-oneconvergence-agent #- Neutron is a virtual network service for Openstack #- One Convergence agent
 sudo apt-get install -y --force-yes neutron-plugin-opencontrail #- Neutron is a virtual network service for Openstack #- OpenContrail plugin
 sudo apt-get install -y --force-yes neutron-plugin-openflow-agent #- Neutron is a virtual network service for Openstack #- Openflow agent
 sudo apt-get install -y --force-yes neutron-plugin-plumgrid #- Neutron is a virtual network service for Openstack #- PLUMgrid plugin
 sudo apt-get install -y --force-yes neutron-plugin-sriov-agent #- Neutron is a virtual network service for Openstack #- IBM agent
 sudo apt-get install -y --force-yes neutron-vpn-agent #- Neutron is a virtual network service for Openstack #- VPN agent
 sudo apt-get install -y --force-yes nova-ajax-console-proxy #- OpenStack Compute #- AJAX console proxy #- transitional package
 sudo apt-get install -y --force-yes nova-api-ec2 #- OpenStack Compute #- EC2 API frontend
 sudo apt-get install -y --force-yes nova-api-metadata #- OpenStack Compute #- metadata API frontend
 sudo apt-get install -y --force-yes nova-api-os-compute #- OpenStack Compute #- OpenStack Compute API frontend
 sudo apt-get install -y --force-yes nova-api-os-volume #- OpenStack Compute #- OpenStack Volume API frontend
 sudo apt-get install -y --force-yes nova-baremetal #- Openstack Compute #- baremetal virt
 sudo apt-get install -y --force-yes nova-cells #- Openstack Compute #- cells
 sudo apt-get install -y --force-yes nova-compute-flex #- Openstack Compute #- Ubuntu Flex container support
 sudo apt-get install -y --force-yes nova-compute-qemu #- OpenStack Compute #- compute node (QEmu)
 sudo apt-get install -y --force-yes nova-compute-vmware #- OpenStack Compute #- compute node (VMware)
 sudo apt-get install -y --force-yes nova-compute-xen #- OpenStack Compute #- compute node (Xen)
 sudo apt-get install -y --force-yes nova-conductor #- OpenStack Compute #- conductor service
 sudo apt-get install -y --force-yes nova-console #- OpenStack Compute #- Console
 sudo apt-get install -y --force-yes nova-consoleauth #- OpenStack Compute #- Console Authenticator
 sudo apt-get install -y --force-yes nova-novncproxy #- OpenStack Compute #- NoVNC proxy
 sudo apt-get install -y --force-yes nova-spiceproxy #- OpenStack Compute #- spice html5 proxy
 sudo apt-get install -y --force-yes nova-xvpvncproxy #- OpenStack Compute #- XVP VNC proxy
 sudo apt-get install -y --force-yes openstack-debian-images #- script to build a Debian image for OpenStack
 sudo apt-get install -y --force-yes openstack-resource-agents #- pacemaker resource agents for OpenStack
 sudo apt-get install -y --force-yes php-opencloud #- library to work with OpenStack clouds
 sudo apt-get install -y --force-yes php-opencloud-doc #- library to work with OpenStack clouds #- documentation
 sudo apt-get install -y --force-yes python-backup2swift #- backup data to OpenStack Swift #- python 2.x
 sudo apt-get install -y --force-yes python-designate #- OpenStack DNS as a Service #- Python libs
 sudo apt-get install -y --force-yes python-designateclient #- client library for the OpenStack Designate API
 sudo apt-get install -y --force-yes python-diskimage-builder #- image building tools for Openstack
 sudo apt-get install -y --force-yes python-ftp-cloudfs #- FTP interface to Rackspace Cloud Files and OpenStack #- Python lib
 sudo apt-get install -y --force-yes python-ironic #- Openstack bare metal provisioning service #- Python library
 sudo apt-get install -y --force-yes python-manilaclient #- python bindings for OpenStack Manila API
 sudo apt-get install -y --force-yes python-nova-adminclient #- client for administering Openstack Nova
 sudo apt-get install -y --force-yes python-nova.flex #- OpenStack Compute Python libraries #- flex driver
 sudo apt-get install -y --force-yes python-openstack-compute #- Python bindings for the Rasckspace Cloud Servers API
 sudo apt-get install -y --force-yes python-openstack-doc-tools #- tools used by the OpenStack Documentation project
 sudo apt-get install -y --force-yes python-openstack.nose-plugin #- nosetests output to mimic the output of openstack's run_tests.py #- Python 2.x
 sudo apt-get install -y --force-yes python-openstackclient #- OpenStack Command-line Client
 sudo apt-get install -y --force-yes python-os-cloud-config #- configuration seed and initialisation for TripleO OpenStack clouds
 sudo apt-get install -y --force-yes python-os-refresh-config #- refresh system configuration of an OpenStack TripleO node
 sudo apt-get install -y --force-yes python-simplestreams-openstack #- Library and tools for using Simple Streams data
 sudo apt-get install -y --force-yes python-sphinxcontrib-docbookrestapi #- generating REST API documentation for api.openstack.org #- transitional package
 sudo apt-get install -y --force-yes python-sphinxcontrib.docbookrestapi #- generating REST API documentation for http://api.openstack.org
 sudo apt-get install -y --force-yes python-swiftsc #- simple client library of OpenStack Swift
 sudo apt-get install -y --force-yes python-tempest #- Openstack integration test suite
 sudo apt-get install -y --force-yes python-tripleo-image-elements #- Image building rules for OpenStack
 sudo apt-get install -y --force-yes python-trove #- Database as a Service for OpenStack #- Python lib
 sudo apt-get install -y --force-yes python-tuskarclient #- control how and where OpenStack services are deployed #- client
 sudo apt-get install -y --force-yes python-tuskarclient-doc #- control how and where OpenStack services are deployed #- client doc
 sudo apt-get install -y --force-yes python3-backup2swift #- backup data to OpenStack Swift #- python 3.x
 sudo apt-get install -y --force-yes python3-hacking #- Flake8 OpenStack Hacking Guidelines Enforcement plugins #- Python 3.x
 sudo apt-get install -y --force-yes python3-openstack.nose-plugin #- nosetests output to mimic the output of openstack's run_tests.py #- Python 3.x
 sudo apt-get install -y --force-yes python3-swiftsc #- simple client library of OpenStack Swift for python3
 sudo apt-get install -y --force-yes sftpcloudfs #- SFTP interface to Rackspace/OpenStack storage services
 sudo apt-get install -y --force-yes tempest #- Openstack integration test suite
 sudo apt-get install -y --force-yes trove-api #- Database as a Service for OpenStack #- API server
 sudo apt-get install -y --force-yes trove-common #- Database as a Service for OpenStack #- common files
 sudo apt-get install -y --force-yes trove-conductor #- Database as a Service for OpenStack #- conductor
 sudo apt-get install -y --force-yes trove-guestagent #- Database as a Service for OpenStack #- guest agent
 sudo apt-get install -y --force-yes trove-taskmanager #- Database as a Service for OpenStack #- taskmanager


