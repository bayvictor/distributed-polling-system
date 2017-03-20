echo "
 
GénéalogieGÉNÉALOGIE LinuxLINUX AndroidANDROID NAS & coNAS & CO MiscMISC

UBUNTU - DECLARE MTP DEVICE FOR AUTOMOUNT IN ONE CLICK (NEXUS 4, NEXUS 7, ...)
Created on 22 Mar 2013, updated on 15 Sep 2013,
by Nicolas Bernaerts
Contents[Hide]
Basic Principle
MTP Fuse Setup & Installation
Configure Fuse
Install go-mtpfs & mtp-tools
Manual Device Declaration
Detect MTP device
Get Device USB Host PCI address
Get Device Model & Model ID
Create Mount Point
Create Udev Rule
Declare Mount Point
One Click Automatic Script
Create the script mtp-declare
Declare a new Device
dropcap-ubuntu-android

android-mtp-protocolLatest Android devices, like Nexus 4, Nexus 7, Galaxy Nexus, ... are using 2 different USB connexion modes : PTP and MTP.

With PTP mode, the phone is seen as a digital camera. This is working Out Of The Box under Ubuntu 12.04 LTS. But, you can only access DCIM directory of your device.

With MTP mode, the phone is seen as a multimedia device where you can access the complete exported filesystem. But it doesn't work Out Of The Box under Ubuntu 12.04 LTS. It needs some setup and configuration to work.

This guide explains how to easily configure your Ubuntu computer to directly access your Android devices filesystem in MTP mode as soon as you plug it to a USB port.

It is based on a previous guide done for Nexus 7, but has been modified to become fully automatic, providing a script which is a one click solution to configure virtually any MTP device.

Thanks to this script, your Android devices will be properly declared to automatically mount when plugged & unmount when unplugged. You'll be able to handle multiple devices at the same time on your ubuntu computer.

This guide has been completly rewritten to use mtp-detect. It has been tested with a Google Nexus 4 and a Google Nexus 7, but it should work with any other MTP device (Android phone or tablet, MP4 player, ...). It has been done under Ubuntu 12.04 LTS Amd64 but it should work or be easily adapted on many Linux flavours.

1. BASIC PRINCIPLE
First, any MTP device needs a MTP handling filesystem to be able to access it as any USB key on a Ubuntu computer. Some fuse based filesystems are available.

Every device will be mounted under /media in a subdirectory specific to each product model.

To be able to eject this device from Nautilus as a non root user, you also need to declare the mount path in /etc/fstab.

Finally, to automatically mount and unmount the device during USB connection and disconnection, you need to setup some specific udev rules that will do the job. 
These rules will be based on the device Vendor ID et Device ID, unique to every product.

All these operations can be done manually from console, but they can also be joined within a script that will do all the declaration job.

So after doing all this declaration job, your MTP device will be recognised by your system and will be accessible like any other mass storage device.

You will be able to access it and unmount it straight from Nautilus in the Devices section.

2. MTP FUSE SETUP & INSTALLATION
First main step is to install a proper fuse extension to handle MTP protocol as a filesystem.

2.1. CONFIGURE FUSE
Because of a bug, Ubuntu 12.04 doesn't allow normal users to access fuse configuration file. This bug is quite easy to correct by giving read attribute to /etc/fuse.conf.

By default, fuse does not allow mounted filesystems to be accessed by anybody else that the user who has mounted it. As MTP filesystem will be mounted by root to be used by any user, we need to modify fuse default behaviour to allow it. This is configured by uncommenting the user_allow_other key in /etc/fuse.conf.
"

echo "^C to break, anykey to continue...."; read readline
 sudo chmod a+r /etc/fuse.conf
 sudo gedit /etc/fuse.conf

echo "/etc/fuse.conf

"
echo "
...
# Allow non-root users to specify the 'allow_other' or 'allow_root' mount options.
user_allow_other

2.2. INSTALL GO-MTPFS & MTP-TOOLS
go-mtpfs is a MTP fuse extension. Its advantage over mtpfs project and jmtpfs is to be overall much more stable and fast for connexion, directory change and file transfer.

There is still some limitation as you can not transfer files bigger than 2 Gb and file timestamp is not preserved

The simplest way to install go-mtpfs is to use the PPA provided by WebUpd8 Team. It will provide latest libmtp and go-mtpfs for Ubuntu 12.04 +.

mtp-tools is also needed as it is providing mtp-detect tool.

# sudo add-apt-repository ppa:webupd8team/unstable
# sudo apt-get update
# sudo apt-get upgrade
# sudo apt-get install mtp-tools go-mtpfs

3. MANUAL DEVICE DECLARATION
If you are only interested in having your device up & running, you can skip this section and jump directly to next One Click Automatic procedure section.

This procedure is quite simple, but based on numerous specific steps :

detect device with mtp-detect
get device characteristics (PCI device address, Vendor & model ID, ...) using udevadm
if needed, create mount point (accessible by any user)
create a udev rule to automatically mount and umount device
reset the USB host, wait for go-mtpfs to mount the device & get the mount point characteristics
if needed, add the device mount point in /etc/fstab & reset the USB host once again to finally mount the device
As an example, it has been done to declare a Nexus 4 device.

The following manual procedure explain in details all the steps needed to declare a MTP device for auto mount & unmount.
It may be of great interest if the One Click Automatic procedure is giving you trouble. 
It will give you a the step by step guide to debug your system and understand where the problem is …

3.1. DETECT MTP DEVICE
After inserting a USB device in MTP mode, you can detect your devices with mtp-detect :

# mtp-detect 2>NULL | grep bus
Google Inc (for LG Electronics/Samsung): Nexus 4/10 (MTP) (18d1:4ee1) @ bus 2, dev 5
Google Inc (for Asus): Nexus 7 (MTP) (18d1:4e41) @ bus 7, dev 74

Here we get for example for a Nexus 4 :

Description : Google Inc (for LG Electronics/Samsung): Nexus 4/10 (MTP)
Vendor ID : 18d1
Device ID : 4ee1
Bus number : 002
Device number : 005
lsusb should give you the same type of information :

# lsusb | grep 18d1
Bus 002 Device 005: ID 18d1:4ee1 Google Inc.
Bus 007 Device 074: ID 18d1:4e41 Google Inc.

3.2. GET DEVICE USB HOST PCI ADDRESS
udevadm allows to get your MTP device full PCI path :

# udevadm info --query=path --name=/dev/bus/usb/002/005
/devices/pci0000:00/0000:00:1d.7/usb2/2-1

Here, USB Host PCI Bus is 0000:00:1d.7

3.3. GET DEVICE MODEL & MODEL ID
udevadm can also give some very detailed informations about the device.

It allows to get your MTP device full PCI address :

# udevadm info --export --query=property --path="/sys/devices/pci0000:00/0000:00:1d.7/usb2/2-1"
...
ID_MODEL='Nexus_4'
...
ID_MODEL_ID='4ee1'
...

Here, Model is Nexus_4 and Model ID is 4ee1.

3.4. CREATE MOUNT POINT
Mount point should be created under /media/ according to the Udev device Model :

# sudo mkdir "/media/Nexus_4"
# chown root:root "/media/Nexus_4"
# sudo chmod 777 "/media/Nexus_4"

3.5. CREATE UDEV RULE
A Udev rule specific to the device needs to be created. Its main role will be to :

mount device with go-mtpfs upon connection
umount device upon disconnection
This rule will be trigered by the Vendor and Device ID, so it will be named according to the device model and both these data.

# sudo gedit /etc/udev/rules.d/99-mtp-Nexus_4-18d1-4ee1.rules

/etc/udev/rules.d/99-mtp-Nexus_4-18d1-4ee1.rules

# Nexus_4 - MTP mount & unmount rules
SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4ee1", MODE="0666", OWNER="your-login"
ENV{ID_MODEL}=="Nexus_4", ENV{ID_MODEL_ID}=="4ee1", ACTION=="add", RUN+="/usr/bin/sudo -b -u your-login /usr/bin/go-mtpfs -dev=18d1:4ee1 -allow-other=true /media/Nexus_4"
ENV{ID_MODEL}=="Nexus_4", ENV{ID_MODEL_ID}=="4ee1", ACTION=="remove", RUN+="/bin/umount /media/Nexus_4"

You now need to restart udev service to accept this new rule :

# sudo service udev restart

3.6. DECLARE MOUNT POINT
Now that the new rule is declared, device should be detected again for the rule to apply.

Under Ubuntu, you can do itu easily by resseting the USB host :

# echo -n "0000:00:1d.7" | tee /sys/bus/pci/drivers/ehci_hcd/unbind
# echo -n "0000:00:1d.7" | tee /sys/bus/pci/drivers/ehci_hcd/bind
# mount
...
DeviceFs(Nexus 4) on /media/Nexus_4 type fuse.DeviceFs(Nexus 4) (rw,nosuid,nodev,allow_other,user=your-login)

After few seconds, the device Nexus 4 should be mounted under /media/Nexus_4.

To be able to unmount your device straight from Nautilus, it needs to be declared in /etc/fstab with its fuse characteristics.

As /etc/fstab is using SPACE as a separator and as Nexus 4 fuse caracteristics include SPACE caracter, we have to convert them to its octal escape code \040.

# sudo gedit /etc/fstab

/etc/fstab

...
# declaration of Nexus 4 to be mounted under /media/Nexus_4
DeviceFs(Nexus\0404)      /media/Nexus_4       fuse.DeviceFs(Nexus\0404) allow_other,rw,user,noauto    0     0

You can check it by resseting the USB port once again :

# echo -n "0000:00:1d.7" | tee /sys/bus/pci/drivers/ehci_hcd/unbind
# echo -n "0000:00:1d.7" | tee /sys/bus/pci/drivers/ehci_hcd/bind

nexus4-ubuntu-precise-mount-deviceAfter few seconds, the device should be mounted in Nautilus in the Devices section.

You are now able to unmount it straight from Nautilus with the eject button.

4. ONE CLICK AUTOMATIC SCRIPT
All previous manual operations can be done straight from one script that will handle all different steps.

This script does all the device declaration job in one go.

You just need to :

connect your MTP device
start the script as sudo
and that's it !

4.1. CREATE THE SCRIPT MTP-DECLARE
Script will be created under /usr/local/sbin
"

echo "
# sudo wget -O /usr/local/sbin/mtp-declare http://bernaerts.dyndns.org/download/ubuntu/mtp-declare
# sudo chmod +x /usr/local/sbin/mtp-declare

/usr/local/sbin/mtp-declare

#!/bin/bash
# ------------------------------------------------------------------------
#  Setup your system to declare a connected MTP device 
#  as an automount device
#  
#  Depends on following packages :
#   * go-mtpfs (from WebUpd8 PPA)
#   * mtp-tools
#   * zenity
#
#  Revision history :
#   07/03/2013, V1.0 - Creation by N. Bernaerts
#   17/03/2013, V1.1 - Add multi-devices support (thanks to Manu Sankala)
#   22/03/2013, V2.0 - Complete rewrite using mtp-detect
#   22/03/2013, V2.1 - Add fuse.conf test (thanks to Stefan Schanz)
# ------------------------------------------------------------------------

# set string separator as \n
IFS="
"

# set default path
PATH_FSTAB="/etc/fstab"

# function with zenity progression display
(
# no error ... so far
MTP_ERROR=""

# determine original user
MTP_USER="$SUDO_USER"

# progress indicator
echo "0" ; echo "# Step 1 - Checking environment" ; sleep 1

# check if go-mtpfs is installed (under /usr/bin if using the PPA)
if [ ! -f "/usr/bin/go-mtpfs" ]; then MTP_ERROR="go-mtpfs is not installed. Install it first."; fi

# check if script is run as sudo
if [ "$MTP_USER" = "" ]; then MTP_ERROR="script must be run as sudo."; fi

# check whether needed user_allow_other option is set in /etc/fuse.conf
FUSE_UAO=`cat /etc/fuse.conf | grep user_allow_other | sed "s/^ *user_allow_other.*$/ok/" | grep ok`
if [ "$FUSE_UAO" = "" ]; then MTP_ERROR="user_allow_other is not declared in /etc/fuse.conf"; fi

# detection of devices
if [ "$MTP_ERROR" = "" ]
then
  # progress indicator
  echo "5" ; echo "# Step 2 - Detection of devices ... this may take a very long time !" ; sleep 1

  # Declare the device list
  MTP_LIST=( `mtp-detect 2>NULL | grep bus | sed 's/^\(.*\) (\([0-9a-f]*\):\([0-9a-f]*\)) .*$/FALSE\n\2:\3 - \1/'` )

  # display the selection dialog box
  MTP_TITLE="MTP device : Selection"
  MTP_QUESTION="Select in the list of connected MTP devices the one you want to declare for automount"
  MTP_SELECT=`zenity --list --width=500 --height=200 --text "$MTP_QUESTION" --title "$MTP_TITLE" --radiolist --column "Select" --column "MTP Device" "${MTP_LIST[@]}"`

  # if no device selected, operation canceled
  if [ "$MTP_SELECT" = "" ]; then MTP_ERROR="No MTP device selected." ; fi
fi

# collection of important data
if [ "$MTP_ERROR" = "" ]
then
  # progress indicator
  echo "40" ; echo "# Step 3 - Collection of device data" ; sleep 1

  # get VENDOR_ID and DEVICE_ID
  MTP_VENDOR_ID=`echo "$MTP_SELECT" | sed 's/^\([0-9a-f]*\):[0-9a-f]* - .*$/\1/'`
  MTP_DEVICE_ID=`echo "$MTP_SELECT" | sed 's/^[0-9a-f]*:\([0-9a-f]*\) - .*$/\1/'`

  # get BUSNUM and DEVNUM
  MTP_BUSNUM=`lsusb | grep "$MTP_VENDOR_ID:$MTP_DEVICE_ID" | sed 's/^Bus \([0-9a-f]*\) Device [0-9a-f]*:.*$/\1/g'`
  MTP_DEVNUM=`lsusb | grep "$MTP_VENDOR_ID:$MTP_DEVICE_ID" | sed 's/^Bus [0-9a-f]* Device \([0-9a-f]*\):.*$/\1/g'`

  # get USB device full PCI path and PCI id
  MTP_PATH=`udevadm info --query=path --name=/dev/bus/usb/$MTP_BUSNUM/$MTP_DEVNUM`
  MTP_USBID=`echo "$MTP_PATH" | sed 's/^.*\/\([0-9]*:[0-9]*:[0-9a-f]*.[0-9]\)\/.*$/\1/g'`

  # get ID_MODEL and ID_MODEL_ID
  MTP_MODEL=`udevadm info --export --query=property --path="$MTP_PATH" | grep "ID_MODEL=" | sed 's/^.*=.\(.*\).$/\1/g'`
  MTP_MODEL_ID=`udevadm info --export --query=property --path="$MTP_PATH" | grep "ID_MODEL_ID=" | sed 's/^.*=.\(.*\).$/\1/g'`
fi

# prepare mount point
if [ "$MTP_ERROR" = "" ]
then
  echo "45" ; echo "# Step 4 - Creation of $MTP_MOUNT directory" ; sleep 1

  # setup mount point as /media/model
  MTP_MOUNT="/media/$MTP_MODEL"

  # MOUNT - if needed, create the mount point
  if [ ! -d "$MTP_MOUNT" ]; then
    mkdir "$MTP_MOUNT"
    chown root:root "$MTP_MOUNT"
    chmod 777 "$MTP_MOUNT"
  fi
fi

# declaration of UDEV rules
if [ "$MTP_ERROR" = "" ]
then
  # progress indicator
  echo "50" ; echo "# Step 5 - Creation of UDEV rules" ; sleep 1

  # UDEV - create the rule
  MTP_RULE="/etc/udev/rules.d/99-mtp-$MTP_MODEL-$MTP_VENDOR_ID-$MTP_DEVICE_ID.rules"
  echo "# $MTP_MODEL - MTP mount & unmount rules " > $MTP_RULE
  echo "SUBSYSTEM==\"usb\", ATTR{idVendor}==\"$MTP_VENDOR_ID\", ATTR{idProduct}==\"$MTP_DEVICE_ID\", MODE=\"0666\", OWNER=\"$MTP_USER\"" >> $MTP_RULE
  echo "ENV{ID_MODEL}==\"$MTP_MODEL\", ENV{ID_MODEL_ID}==\"$MTP_MODEL_ID\", ACTION==\"add\", RUN+=\"/usr/bin/sudo -b -u $MTP_USER /usr/bin/go-mtpfs -dev=$MTP_VENDOR_ID:$MTP_DEVICE_ID -allow-other=true /media/$MTP_MODEL\"" >> $MTP_RULE
  echo "ENV{ID_MODEL}==\"$MTP_MODEL\", ENV{ID_MODEL_ID}==\"$MTP_MODEL_ID\", ACTION==\"remove\", RUN+=\"/bin/umount /media/$MTP_MODEL\"" >> $MTP_RULE
  echo " " >> $MTP_RULE

  # UDEV - restart the service
  service udev restart
fi

# device detection according to new UDEV rules
if [ "$MTP_ERROR" = "" ]
then
  # progress indicator
  echo "80" ; echo "# Step 6 - Device detection ... if more than 10s, reconnect the device" ; sleep 1

  # USB - first reset of host to force device reconnexion
  echo -n "$MTP_USBID" | tee /sys/bus/pci/drivers/ehci_hcd/unbind
  echo -n "$MTP_USBID" | tee /sys/bus/pci/drivers/ehci_hcd/bind

  # GO-MTPFS - loop till the device has been detected again
  MTP_LINE=""
  while [ "$MTP_LINE" = "" ]
  do    
    # wait for 2 seconds
    sleep 2

    # check if device has been detected by go-mtpfs
    MTP_LINE=`mount | grep "$MTP_MOUNT"`
  done

  # GO-MTPFS - check if line in mount is having proper format (starts by DeviceFS and holds fuse.DeviceFs)
  MTP_OK=`echo $MTP_LINE | sed 's/^DeviceFs(.*) .* fuse.DeviceFs(.*) .*$/ok/g'`
  if [ "$MTP_OK" != "ok" ]; then MTP_ERROR="mount command returns an improper $MTP_MOUNT line"; fi
fi

# declaration in /etc/fstab
if [ "$MTP_ERROR" = "" ]
then
  # progress indicator
  echo "90" ; echo "# Step 7 - Declaration of device mount point" ; sleep 1

  # check if /etc/fstab doesn't already handle mount path
  MTP_OK=`cat "$PATH_FSTAB" | grep "$MTP_MOUNT"`

  # if device has to be declared in /etc/fstab
  if [ "$MTP_OK" = "" ]
  then
    # get fuse mount caracteristics
    FSTAB_DEVICE=`mount | grep "$MTP_MOUNT" | sed 's/^.*(\(.*\)) on.*$/\1/g'`
    FSTAB_FUSE=`mount | grep "$MTP_MOUNT" | sed 's/^.*type .*(\(.*\)) .*$/\1/g'`

    # append device mount line to /etc/fstab, any ' ' will be replaced by '\040'
    echo "# declaration of $FSTAB_DEVICE to be mounted under $MTP_MOUNT" >> "$PATH_FSTAB"
    echo "DeviceFs($FSTAB_DEVICE)|$MTP_MOUNT|fuse.DeviceFs($FSTAB_FUSE)|allow_other,rw,user,noauto|0|0" | sed 's/ /\\040/g' | sed 's/|/    /g' >> "$PATH_FSTAB"

    # reset USB host to force device reconnection and mount it as device  
    echo "90" ; echo "# Step 9 - Second reset of USB host" ; sleep 1
    echo -n "$MTP_USBID" | tee /sys/bus/pci/drivers/ehci_hcd/unbind
    echo -n "$MTP_USBID" | tee /sys/bus/pci/drivers/ehci_hcd/bind

    # FINISHED - declare mount point in /etc/fstab
    echo "100" ; echo "# Finished ! Your $MTP_MODEL should be seen as a device" ; sleep 1

  # else, warning, device already declared in /etc/fstab
  else 
    echo "100" ; echo "# Finished ! Device declared but $MTP_MOUNT already present" ; sleep 1
  fi
fi

# in case of error, display message
if [ "$MTP_ERROR" != "" ]; then echo "100" ; echo "# Error - $MTP_ERROR" ; sleep 1 ; fi
) | zenity --progress --pulsate --width=500 --title "Declaration of a new MTP device"

4.2. DECLARE A NEW DEVICE
Now, when you want to declare a new MTP device on your computer, the only thing to do is to :

connect your MTP device
launch the script as root
Make sure your device is in MTP mode and that it is not screen locked (or filesystem access will fail).

# sudo mtp-declare

Your device detection by mtp-detect may take quite a long time.

ubuntu-mtp-declare-nexus4-detection

At the end of the detection process, you'll have to select the device you want to declare for automount.

ubuntu-mtp-declare-nexus4-selection

If your device is screen locked, the last mount operation will fail ...

At the end, if everything has gone fine, you should get a confirmation screen.

ubuntu-mtp-declare-nexus4-final

nexus4-ubuntu-precise-mount-deviceIn case of problem, you should get an error message explaining where the problem is.

You can now connect & disconnect your device any time and access it thru MTP as any Mass Storage Device.

 

If you've got some success with your non Nexus MTP device, just let me know by mail. Enjoy !

This article is published "as is", without any warranty that it will work for your specific need.
If you think this article needs some complement, or simply if you think it saved you lots of time & trouble,
just let me know at nicolas.bernaerts@laposte.net. Cheers !

icon linux icon debian icon apache icon mysql icon php icon piwik icon googleplus

" > 
 
GénéalogieGÉNÉALOGIE LinuxLINUX AndroidANDROID NAS & coNAS & CO MiscMISC

UBUNTU - DECLARE MTP DEVICE FOR AUTOMOUNT IN ONE CLICK (NEXUS 4, NEXUS 7, ...)
Created on 22 Mar 2013, updated on 15 Sep 2013,
by Nicolas Bernaerts
Contents[Hide]
Basic Principle
MTP Fuse Setup & Installation
Configure Fuse
Install go-mtpfs & mtp-tools
Manual Device Declaration
Detect MTP device
Get Device USB Host PCI address
Get Device Model & Model ID
Create Mount Point
Create Udev Rule
Declare Mount Point
One Click Automatic Script
Create the script mtp-declare
Declare a new Device
dropcap-ubuntu-android

android-mtp-protocolLatest Android devices, like Nexus 4, Nexus 7, Galaxy Nexus, ... are using 2 different USB connexion modes : PTP and MTP.

With PTP mode, the phone is seen as a digital camera. This is working Out Of The Box under Ubuntu 12.04 LTS. But, you can only access DCIM directory of your device.

With MTP mode, the phone is seen as a multimedia device where you can access the complete exported filesystem. But it doesn't work Out Of The Box under Ubuntu 12.04 LTS. It needs some setup and configuration to work.

This guide explains how to easily configure your Ubuntu computer to directly access your Android devices filesystem in MTP mode as soon as you plug it to a USB port.

It is based on a previous guide done for Nexus 7, but has been modified to become fully automatic, providing a script which is a one click solution to configure virtually any MTP device.

Thanks to this script, your Android devices will be properly declared to automatically mount when plugged & unmount when unplugged. You'll be able to handle multiple devices at the same time on your ubuntu computer.

This guide has been completly rewritten to use mtp-detect. It has been tested with a Google Nexus 4 and a Google Nexus 7, but it should work with any other MTP device (Android phone or tablet, MP4 player, ...). It has been done under Ubuntu 12.04 LTS Amd64 but it should work or be easily adapted on many Linux flavours.

1. BASIC PRINCIPLE
First, any MTP device needs a MTP handling filesystem to be able to access it as any USB key on a Ubuntu computer. Some fuse based filesystems are available.

Every device will be mounted under /media in a subdirectory specific to each product model.

To be able to eject this device from Nautilus as a non root user, you also need to declare the mount path in /etc/fstab.

Finally, to automatically mount and unmount the device during USB connection and disconnection, you need to setup some specific udev rules that will do the job. 
These rules will be based on the device Vendor ID et Device ID, unique to every product.

All these operations can be done manually from console, but they can also be joined within a script that will do all the declaration job.

So after doing all this declaration job, your MTP device will be recognised by your system and will be accessible like any other mass storage device.

You will be able to access it and unmount it straight from Nautilus in the Devices section.

2. MTP FUSE SETUP & INSTALLATION
First main step is to install a proper fuse extension to handle MTP protocol as a filesystem.

2.1. CONFIGURE FUSE
Because of a bug, Ubuntu 12.04 doesn't allow normal users to access fuse configuration file. This bug is quite easy to correct by giving read attribute to /etc/fuse.conf.

By default, fuse does not allow mounted filesystems to be accessed by anybody else that the user who has mounted it. As MTP filesystem will be mounted by root to be used by any user, we need to modify fuse default behaviour to allow it. This is configured by uncommenting the user_allow_other key in /etc/fuse.conf.

# sudo chmod a+r /etc/fuse.conf
# sudo gedit /etc/fuse.conf

/etc/fuse.conf

...
# Allow non-root users to specify the 'allow_other' or 'allow_root' mount options.
user_allow_other

2.2. INSTALL GO-MTPFS & MTP-TOOLS
go-mtpfs is a MTP fuse extension. Its advantage over mtpfs project and jmtpfs is to be overall much more stable and fast for connexion, directory change and file transfer.

There is still some limitation as you can not transfer files bigger than 2 Gb and file timestamp is not preserved

The simplest way to install go-mtpfs is to use the PPA provided by WebUpd8 Team. It will provide latest libmtp and go-mtpfs for Ubuntu 12.04 +.

mtp-tools is also needed as it is providing mtp-detect tool.

# sudo add-apt-repository ppa:webupd8team/unstable
# sudo apt-get update
# sudo apt-get upgrade
# sudo apt-get install mtp-tools go-mtpfs

3. MANUAL DEVICE DECLARATION
If you are only interested in having your device up & running, you can skip this section and jump directly to next One Click Automatic procedure section.

This procedure is quite simple, but based on numerous specific steps :

detect device with mtp-detect
get device characteristics (PCI device address, Vendor & model ID, ...) using udevadm
if needed, create mount point (accessible by any user)
create a udev rule to automatically mount and umount device
reset the USB host, wait for go-mtpfs to mount the device & get the mount point characteristics
if needed, add the device mount point in /etc/fstab & reset the USB host once again to finally mount the device
As an example, it has been done to declare a Nexus 4 device.

The following manual procedure explain in details all the steps needed to declare a MTP device for auto mount & unmount.
It may be of great interest if the One Click Automatic procedure is giving you trouble. 
It will give you a the step by step guide to debug your system and understand where the problem is …

3.1. DETECT MTP DEVICE
After inserting a USB device in MTP mode, you can detect your devices with mtp-detect :

# mtp-detect 2>NULL | grep bus
Google Inc (for LG Electronics/Samsung): Nexus 4/10 (MTP) (18d1:4ee1) @ bus 2, dev 5
Google Inc (for Asus): Nexus 7 (MTP) (18d1:4e41) @ bus 7, dev 74

Here we get for example for a Nexus 4 :

Description : Google Inc (for LG Electronics/Samsung): Nexus 4/10 (MTP)
Vendor ID : 18d1
Device ID : 4ee1
Bus number : 002
Device number : 005
lsusb should give you the same type of information :

# lsusb | grep 18d1
Bus 002 Device 005: ID 18d1:4ee1 Google Inc.
Bus 007 Device 074: ID 18d1:4e41 Google Inc.

3.2. GET DEVICE USB HOST PCI ADDRESS
udevadm allows to get your MTP device full PCI path :

# udevadm info --query=path --name=/dev/bus/usb/002/005
/devices/pci0000:00/0000:00:1d.7/usb2/2-1

Here, USB Host PCI Bus is 0000:00:1d.7

3.3. GET DEVICE MODEL & MODEL ID
udevadm can also give some very detailed informations about the device.

It allows to get your MTP device full PCI address :

# udevadm info --export --query=property --path="/sys/devices/pci0000:00/0000:00:1d.7/usb2/2-1"
...
ID_MODEL='Nexus_4'
...
ID_MODEL_ID='4ee1'
...

Here, Model is Nexus_4 and Model ID is 4ee1.

3.4. CREATE MOUNT POINT
Mount point should be created under /media/ according to the Udev device Model :

# sudo mkdir "/media/Nexus_4"
# chown root:root "/media/Nexus_4"
# sudo chmod 777 "/media/Nexus_4"

3.5. CREATE UDEV RULE
A Udev rule specific to the device needs to be created. Its main role will be to :

mount device with go-mtpfs upon connection
umount device upon disconnection
This rule will be trigered by the Vendor and Device ID, so it will be named according to the device model and both these data.

# sudo gedit /etc/udev/rules.d/99-mtp-Nexus_4-18d1-4ee1.rules

/etc/udev/rules.d/99-mtp-Nexus_4-18d1-4ee1.rules

# Nexus_4 - MTP mount & unmount rules
SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4ee1", MODE="0666", OWNER="your-login"
ENV{ID_MODEL}=="Nexus_4", ENV{ID_MODEL_ID}=="4ee1", ACTION=="add", RUN+="/usr/bin/sudo -b -u your-login /usr/bin/go-mtpfs -dev=18d1:4ee1 -allow-other=true /media/Nexus_4"
ENV{ID_MODEL}=="Nexus_4", ENV{ID_MODEL_ID}=="4ee1", ACTION=="remove", RUN+="/bin/umount /media/Nexus_4"

You now need to restart udev service to accept this new rule :

# sudo service udev restart

3.6. DECLARE MOUNT POINT
Now that the new rule is declared, device should be detected again for the rule to apply.

Under Ubuntu, you can do itu easily by resseting the USB host :

# echo -n "0000:00:1d.7" | tee /sys/bus/pci/drivers/ehci_hcd/unbind
# echo -n "0000:00:1d.7" | tee /sys/bus/pci/drivers/ehci_hcd/bind
# mount
...
DeviceFs(Nexus 4) on /media/Nexus_4 type fuse.DeviceFs(Nexus 4) (rw,nosuid,nodev,allow_other,user=your-login)

After few seconds, the device Nexus 4 should be mounted under /media/Nexus_4.

To be able to unmount your device straight from Nautilus, it needs to be declared in /etc/fstab with its fuse characteristics.

As /etc/fstab is using SPACE as a separator and as Nexus 4 fuse caracteristics include SPACE caracter, we have to convert them to its octal escape code \040.

# sudo gedit /etc/fstab

/etc/fstab

...
# declaration of Nexus 4 to be mounted under /media/Nexus_4
DeviceFs(Nexus\0404)      /media/Nexus_4       fuse.DeviceFs(Nexus\0404) allow_other,rw,user,noauto    0     0

You can check it by resseting the USB port once again :

# echo -n "0000:00:1d.7" | tee /sys/bus/pci/drivers/ehci_hcd/unbind
# echo -n "0000:00:1d.7" | tee /sys/bus/pci/drivers/ehci_hcd/bind

nexus4-ubuntu-precise-mount-deviceAfter few seconds, the device should be mounted in Nautilus in the Devices section.

You are now able to unmount it straight from Nautilus with the eject button.

4. ONE CLICK AUTOMATIC SCRIPT
All previous manual operations can be done straight from one script that will handle all different steps.

This script does all the device declaration job in one go.

You just need to :

connect your MTP device
start the script as sudo
and that's it !

4.1. CREATE THE SCRIPT MTP-DECLARE
Script will be created under /usr/local/sbin

# sudo wget -O /usr/local/sbin/mtp-declare http://bernaerts.dyndns.org/download/ubuntu/mtp-declare
# sudo chmod +x /usr/local/sbin/mtp-declare

/usr/local/sbin/mtp-declare

#!/bin/bash
# ------------------------------------------------------------------------
#  Setup your system to declare a connected MTP device 
#  as an automount device
#  
#  Depends on following packages :
#   * go-mtpfs (from WebUpd8 PPA)
#   * mtp-tools
#   * zenity
#
#  Revision history :
#   07/03/2013, V1.0 - Creation by N. Bernaerts
#   17/03/2013, V1.1 - Add multi-devices support (thanks to Manu Sankala)
#   22/03/2013, V2.0 - Complete rewrite using mtp-detect
#   22/03/2013, V2.1 - Add fuse.conf test (thanks to Stefan Schanz)
# ------------------------------------------------------------------------

# set string separator as \n
IFS="
"

# set default path
PATH_FSTAB="/etc/fstab"

# function with zenity progression display
(
# no error ... so far
MTP_ERROR=""

# determine original user
MTP_USER="$SUDO_USER"

# progress indicator
echo "0" ; echo "# Step 1 - Checking environment" ; sleep 1

# check if go-mtpfs is installed (under /usr/bin if using the PPA)
if [ ! -f "/usr/bin/go-mtpfs" ]; then MTP_ERROR="go-mtpfs is not installed. Install it first."; fi

# check if script is run as sudo
if [ "$MTP_USER" = "" ]; then MTP_ERROR="script must be run as sudo."; fi

# check whether needed user_allow_other option is set in /etc/fuse.conf
FUSE_UAO=`cat /etc/fuse.conf | grep user_allow_other | sed "s/^ *user_allow_other.*$/ok/" | grep ok`
if [ "$FUSE_UAO" = "" ]; then MTP_ERROR="user_allow_other is not declared in /etc/fuse.conf"; fi

# detection of devices
if [ "$MTP_ERROR" = "" ]
then
  # progress indicator
  echo "5" ; echo "# Step 2 - Detection of devices ... this may take a very long time !" ; sleep 1

  # Declare the device list
  MTP_LIST=( `mtp-detect 2>NULL | grep bus | sed 's/^\(.*\) (\([0-9a-f]*\):\([0-9a-f]*\)) .*$/FALSE\n\2:\3 - \1/'` )

  # display the selection dialog box
  MTP_TITLE="MTP device : Selection"
  MTP_QUESTION="Select in the list of connected MTP devices the one you want to declare for automount"
  MTP_SELECT=`zenity --list --width=500 --height=200 --text "$MTP_QUESTION" --title "$MTP_TITLE" --radiolist --column "Select" --column "MTP Device" "${MTP_LIST[@]}"`

  # if no device selected, operation canceled
  if [ "$MTP_SELECT" = "" ]; then MTP_ERROR="No MTP device selected." ; fi
fi

# collection of important data
if [ "$MTP_ERROR" = "" ]
then
  # progress indicator
  echo "40" ; echo "# Step 3 - Collection of device data" ; sleep 1

  # get VENDOR_ID and DEVICE_ID
  MTP_VENDOR_ID=`echo "$MTP_SELECT" | sed 's/^\([0-9a-f]*\):[0-9a-f]* - .*$/\1/'`
  MTP_DEVICE_ID=`echo "$MTP_SELECT" | sed 's/^[0-9a-f]*:\([0-9a-f]*\) - .*$/\1/'`

  # get BUSNUM and DEVNUM
  MTP_BUSNUM=`lsusb | grep "$MTP_VENDOR_ID:$MTP_DEVICE_ID" | sed 's/^Bus \([0-9a-f]*\) Device [0-9a-f]*:.*$/\1/g'`
  MTP_DEVNUM=`lsusb | grep "$MTP_VENDOR_ID:$MTP_DEVICE_ID" | sed 's/^Bus [0-9a-f]* Device \([0-9a-f]*\):.*$/\1/g'`

  # get USB device full PCI path and PCI id
  MTP_PATH=`udevadm info --query=path --name=/dev/bus/usb/$MTP_BUSNUM/$MTP_DEVNUM`
  MTP_USBID=`echo "$MTP_PATH" | sed 's/^.*\/\([0-9]*:[0-9]*:[0-9a-f]*.[0-9]\)\/.*$/\1/g'`

  # get ID_MODEL and ID_MODEL_ID
  MTP_MODEL=`udevadm info --export --query=property --path="$MTP_PATH" | grep "ID_MODEL=" | sed 's/^.*=.\(.*\).$/\1/g'`
  MTP_MODEL_ID=`udevadm info --export --query=property --path="$MTP_PATH" | grep "ID_MODEL_ID=" | sed 's/^.*=.\(.*\).$/\1/g'`
fi

# prepare mount point
if [ "$MTP_ERROR" = "" ]
then
  echo "45" ; echo "# Step 4 - Creation of $MTP_MOUNT directory" ; sleep 1

  # setup mount point as /media/model
  MTP_MOUNT="/media/$MTP_MODEL"

  # MOUNT - if needed, create the mount point
  if [ ! -d "$MTP_MOUNT" ]; then
    mkdir "$MTP_MOUNT"
    chown root:root "$MTP_MOUNT"
    chmod 777 "$MTP_MOUNT"
  fi
fi

# declaration of UDEV rules
if [ "$MTP_ERROR" = "" ]
then
  # progress indicator
  echo "50" ; echo "# Step 5 - Creation of UDEV rules" ; sleep 1

  # UDEV - create the rule
  MTP_RULE="/etc/udev/rules.d/99-mtp-$MTP_MODEL-$MTP_VENDOR_ID-$MTP_DEVICE_ID.rules"
  echo "# $MTP_MODEL - MTP mount & unmount rules " > $MTP_RULE
  echo "SUBSYSTEM==\"usb\", ATTR{idVendor}==\"$MTP_VENDOR_ID\", ATTR{idProduct}==\"$MTP_DEVICE_ID\", MODE=\"0666\", OWNER=\"$MTP_USER\"" >> $MTP_RULE
  echo "ENV{ID_MODEL}==\"$MTP_MODEL\", ENV{ID_MODEL_ID}==\"$MTP_MODEL_ID\", ACTION==\"add\", RUN+=\"/usr/bin/sudo -b -u $MTP_USER /usr/bin/go-mtpfs -dev=$MTP_VENDOR_ID:$MTP_DEVICE_ID -allow-other=true /media/$MTP_MODEL\"" >> $MTP_RULE
  echo "ENV{ID_MODEL}==\"$MTP_MODEL\", ENV{ID_MODEL_ID}==\"$MTP_MODEL_ID\", ACTION==\"remove\", RUN+=\"/bin/umount /media/$MTP_MODEL\"" >> $MTP_RULE
  echo " " >> $MTP_RULE

  # UDEV - restart the service
  service udev restart
fi

# device detection according to new UDEV rules
if [ "$MTP_ERROR" = "" ]
then
  # progress indicator
  echo "80" ; echo "# Step 6 - Device detection ... if more than 10s, reconnect the device" ; sleep 1

  # USB - first reset of host to force device reconnexion
  echo -n "$MTP_USBID" | tee /sys/bus/pci/drivers/ehci_hcd/unbind
  echo -n "$MTP_USBID" | tee /sys/bus/pci/drivers/ehci_hcd/bind

  # GO-MTPFS - loop till the device has been detected again
  MTP_LINE=""
  while [ "$MTP_LINE" = "" ]
  do    
    # wait for 2 seconds
    sleep 2

    # check if device has been detected by go-mtpfs
    MTP_LINE=`mount | grep "$MTP_MOUNT"`
  done

  # GO-MTPFS - check if line in mount is having proper format (starts by DeviceFS and holds fuse.DeviceFs)
  MTP_OK=`echo $MTP_LINE | sed 's/^DeviceFs(.*) .* fuse.DeviceFs(.*) .*$/ok/g'`
  if [ "$MTP_OK" != "ok" ]; then MTP_ERROR="mount command returns an improper $MTP_MOUNT line"; fi
fi

# declaration in /etc/fstab
if [ "$MTP_ERROR" = "" ]
then
  # progress indicator
  echo "90" ; echo "# Step 7 - Declaration of device mount point" ; sleep 1

  # check if /etc/fstab doesn't already handle mount path
  MTP_OK=`cat "$PATH_FSTAB" | grep "$MTP_MOUNT"`

  # if device has to be declared in /etc/fstab
  if [ "$MTP_OK" = "" ]
  then
    # get fuse mount caracteristics
    FSTAB_DEVICE=`mount | grep "$MTP_MOUNT" | sed 's/^.*(\(.*\)) on.*$/\1/g'`
    FSTAB_FUSE=`mount | grep "$MTP_MOUNT" | sed 's/^.*type .*(\(.*\)) .*$/\1/g'`

    # append device mount line to /etc/fstab, any ' ' will be replaced by '\040'
    echo "# declaration of $FSTAB_DEVICE to be mounted under $MTP_MOUNT" >> "$PATH_FSTAB"
    echo "DeviceFs($FSTAB_DEVICE)|$MTP_MOUNT|fuse.DeviceFs($FSTAB_FUSE)|allow_other,rw,user,noauto|0|0" | sed 's/ /\\040/g' | sed 's/|/    /g' >> "$PATH_FSTAB"

    # reset USB host to force device reconnection and mount it as device  
    echo "90" ; echo "# Step 9 - Second reset of USB host" ; sleep 1
    echo -n "$MTP_USBID" | tee /sys/bus/pci/drivers/ehci_hcd/unbind
    echo -n "$MTP_USBID" | tee /sys/bus/pci/drivers/ehci_hcd/bind

    # FINISHED - declare mount point in /etc/fstab
    echo "100" ; echo "# Finished ! Your $MTP_MODEL should be seen as a device" ; sleep 1

  # else, warning, device already declared in /etc/fstab
  else 
    echo "100" ; echo "# Finished ! Device declared but $MTP_MOUNT already present" ; sleep 1
  fi
fi

# in case of error, display message
if [ "$MTP_ERROR" != "" ]; then echo "100" ; echo "# Error - $MTP_ERROR" ; sleep 1 ; fi
) | zenity --progress --pulsate --width=500 --title "Declaration of a new MTP device"

4.2. DECLARE A NEW DEVICE
Now, when you want to declare a new MTP device on your computer, the only thing to do is to :

connect your MTP device
launch the script as root
Make sure your device is in MTP mode and that it is not screen locked (or filesystem access will fail).

# sudo mtp-declare

Your device detection by mtp-detect may take quite a long time.

ubuntu-mtp-declare-nexus4-detection

At the end of the detection process, you'll have to select the device you want to declare for automount.

ubuntu-mtp-declare-nexus4-selection

If your device is screen locked, the last mount operation will fail ...

At the end, if everything has gone fine, you should get a confirmation screen.

ubuntu-mtp-declare-nexus4-final

nexus4-ubuntu-precise-mount-deviceIn case of problem, you should get an error message explaining where the problem is.

You can now connect & disconnect your device any time and access it thru MTP as any Mass Storage Device.

 

If you've got some success with your non Nexus MTP device, just let me know by mail. Enjoy !

This article is published "as is", without any warranty that it will work for your specific need.
If you think this article needs some complement, or simply if you think it saved you lots of time & trouble,
just let me know at nicolas.bernaerts@laposte.net. Cheers !

icon linux icon debian icon apache icon mysql icon php icon piwik icon googleplus






