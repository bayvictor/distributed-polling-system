echo "Installing The Canonical Distribution of Ubuntu OpenStack

By far the best way to build an OpenStack cloud is by using The Canonical Distribution of Ubuntu OpenStack. Follow the instructions below to download and configure it.

Get the facts ›

What makes up the Canonical Distribution and what support is available for it?

Factsheet

    1

    Installing Ubuntu OpenStack requires at least seven machines with two disks, two of which have two network interfaces (NICs). Install Ubuntu Server on one of the machines with two interfaces.

    You need to setup a private network with all machines plugged in, with the network divided into three logical ranges
        Dynamic range — that has as many IPs as there are total NICs connected to the network
        Static range — that has as many IPs as there are machines connected to the network
        Floating IP range — that has as many IPs as instances that you'll have in your cloud
    Feedback

    Do you have any questions or feedback about setting up The Canonical Distribution of Ubuntu OpenStack?
    Talk to us on Ask Ubuntu
    2

    From the command line type the commands below and follow the step-by-step instructions:
"
sudo apt-get install lxc-docker
 sudo apt-get install -y --force-yes docker #- System tray for KDE3/GNOME2 docklet applications
 sudo apt-get install -y --force-yes docker.io #- Linux container runtime


    sudo add-apt-repository ppa:juju/stable
    sudo add-apt-repository ppa:maas-maintainers/stable
    sudo add-apt-repository ppa:cloud-installer/testing
    sudo apt update

echo "    3

    If you do not already have an existing MAAS server, next you need to setup MAAS. From the command line type the commands below and follow the step-by-step instructions:
"
    sudo apt install maas

echo "        Access the MAAS UI at http://maas.ip/MAAS/ and follow the instructions to create the administrator, then login with those credentials
        Import disk images for 14.04 LTS 64 bit
        Add your SSH key to your user profile - http://maas.ip/MAAS/account/prefs/
        Copy the MAAS key - you will need this later
        Fill in the other details, like gateway and DNS, in the networks that were auto-created for each NIC

    Next you need configure the MAAS cluster:
        Click on the ‘Clusters’ tab and select ‘Cluster master’
        You will see a list of network interfaces on the machine, click the edit symbol for the interface that is connected to the private network where all the nodes are visible
        Set this interface to manage DHCP and DNS
        Set the ‘Router IP’ to the default gateway for this private network
        Fill in details for the dynamic and static ranges, remembering to leave gaps for the floating IPs
        Save the changes
i"

echo "^C to break, anykey to continue...."; read readline


echo "    Now you need to enlist and commission machines:
        Ensure all machines are set to PXE boot, if possible disable all other boot options, including local disk, in the BIOS
        Enlist the machines by powering them on. This can usually be done by some sort of virtual console. They will all appear in the node list in MAAS and be powered down again
        Edit each machine in the nodes list and fill in the Power type and power parameters (i.e. username and password) so that MAAS can turn them on and off as needed
        Select all of the machines and, using the Bulk action dropdown, Commission them
        Wait until all machines are commissioned (i.e. in Ready state)
    4

    Setup Landscape and launch the OpenStack Autopilot
"
    sudo apt install openstack
    sudo openstack-install

echo "        Choose the Landscape OpenStack Autopilot option
        Fill in your MAAS credentials using the MAAS key that you saved when you set up MAAS
        Open the link to access the Landscape UI
        Resolve any remaining issues on checklist, finally clicking the "Configure" button
    5

    Go to the given URL to get to the landing page of the Landscape UI.
    6

    The landing page contains a checklist at the bottom showing the status of all of your resources. Unless something has gone wrong, these should all be green at this point.
    7

    Click on “Configure” and enter an optional name for your region and cloud.
    8

    Select your components (this is an initial list; more options will be added in later versions as they pass the tests in the OpenStack Interoperability Lab)
        Hypervisor component (KVM)
        Networking component (Open vSwitch)

        Storage components
            Object (Ceph, Swift)
            Block (Ceph, iSCSI)
    9

    Select the hardware on which to deploy the cloud and click “Save selection”.
    10
"
echo "    Click “Install” to build your cloud.
    11

    Start using your cloud!

Already a Landscape Dedicated Server customer? Upgrading is simple, see the instructions in the release notes.
Installation guides

If you need some help installing Ubuntu, please check out our step-by-step guides.

    Installation instructions for Ubuntu Server ›
    Using Ubuntu OpenStack - The Canonical Distribution ›

Detailed documentation

    Ubuntu Server Guide
    Ubuntu 14.04 LTS documentation
    Ubuntu 14.10 documentation

Helping hands

If you get stuck, help is always at hand.

    Ask Ubuntu
    Ubuntu Forums
    Ubuntu Discourse
i"

