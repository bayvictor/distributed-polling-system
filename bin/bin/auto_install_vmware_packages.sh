# apt-cache search vmware|sed 's/ - / #- /g;s/^/sudo apt-get install -y /g'>~/bin/auto_install_vmware_packages.sh


sudo apt-get install -y xserver-xorg-input-vmmouse #- X.Org X server -- VMMouse input driver to use with VMWare
sudo apt-get install -y xserver-xorg-video-vmware #- X.Org X server -- VMware display driver
sudo apt-get install -y imvirt #- detects several virtualizations
sudo apt-get install -y libimvirt-perl #- Perl module for detecting several virtualizations
sudo apt-get install -y libview-dev #- VMware's Incredibly Exciting Widgets
sudo apt-get install -y libview2 #- VMware's Incredibly Exciting Widgets
sudo apt-get install -y libview2-dbg #- VMware's Incredibly Exciting Widgets
sudo apt-get install -y python-vm-builder #- VM builder
sudo apt-get install -y virt-goodies #- A collection of helpful virtualisation related tools
sudo apt-get install -y vmfs-tools #- Tools to access VMFS filesystems
sudo apt-get install -y xmount #- tool to crossmount between multiple input and output harddisk images
sudo apt-get install -y vmware-view-open-client #- VMware View Open Client
sudo apt-get install -y open-vm-dkms #- Source for VMware guest systems driver (DKMS)
sudo apt-get install -y open-vm-source #- Source for VMware guest systems driver
sudo apt-get install -y open-vm-toolbox #- tools and components for VMware guest systems (GUI tools)
sudo apt-get install -y open-vm-tools #- tools and components for VMware guest systems (CLI tools)
sudo apt-get install -y open-vm-tools-dbg #- tools and components for VMware guest systems (debug)
