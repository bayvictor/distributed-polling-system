sudo apt-get update

echo "then install Scratchbox:
"
 
sudo apt-get install scratchbox-core scratchbox-devkit-apt-https scratchbox-devkit-autotools-legacy scratchbox-devkit-debian-squeeze scratchbox-devkit-doctools scratchbox-devkit-git scratchbox-devkit-perl scratchbox-devkit-python-legacy scratchbox-devkit-qemu scratchbox-devkit-svn scratchbox-libs scratchbox-toolchain-cs2007q3-glibc2.5-arm7 scratchbox-toolchain-cs2007q3-glibc2.5-i486 scratchbox-toolchain-host-gcc

echo " 
The installation will ask you some questions about users and groups to set up.

4. Download the SDK setup script:

$ "

wget http://repository.maemo.org/stable/5.0/maemo-sdk-install_5.0.sh

echo "5. Since Scratchbox Hathor is based on Debian Squeeze, and the SDK script assumes etch is to be used, we need to make a small change to it:

$ "

sed -i -e 's/etch/squeeze/g' maemo-sdk-install_5.0.sh

echo "6. Set the permissions to execute the script:

$ "
chmod +x maemo-sdk-install_5.0.sh
echo "
7. Users of Ubuntu 10.04 LTS will need to do the following to fix the installation, note that this may reduce system security! [1]

#$ echo "vm.mmap_min_addr = 0" | sudo tee -a /etc/sysctl.conf
$ sudo sysctl -p

8. If you have not already added a user to scratchbox, do so now:

$ "
#sudo chmod +x  /scratchbox/sbin/sbox_adduser
sudo chmod +x /scratchbox/login
sudo /scratchbox/sbin/sbox_adduser vhuang 

echo "At this step, you should have a working Scratchbox environment ready.

9. Proceed further to run the Maemo SDK installer script. This script is run as <user> outside the Scratchbox environment.

$ "

./maemo-sdk-install_5.0.sh

echo "10. If you are installing running this script in Ubuntu 10.10 Maverick Meerkat, you might find the following error: Error opening terminal: xterm In that case follow the instructions at http://www.terabyteunlimited.com/kb/article.php?id=454

11. If you have installed Scratchbox in a path alternative to /scratchbox, you will need to specify the path with ‘-s PATH’ option. More information on available command line options can be found with --help option. Follow the instructions on the go.

11. Once the script has successfully completed its execution, you can login into Scratchbox.

$ "

/scratchbox/login

echo "If you are not able to login, take a look at the limitations of Scratchbox.

12. Proceed further to accept the EULA in order to obtain the Nokia proprietary binary packages. These Nokia binaries are essential for the complete functionality of the Maemo SDK:

12.1. Accept the EULA on this webpage
12.2. Copy the sources.list entry given to you after the license acceptance to your Scratchbox x86 and armel target’s /etc/apt/sources.list file. Execute the commands below on the FREMANTLE_ARMEL and FREMANTLE_X86 targets.

[sbox-FREMANTLE_X86: ~] > sb-conf select FREMANTLE_ARMEL
[sbox-FREMANTLE_ARMEL: ~] > nano /etc/apt/sources.list  # add deb line 
[sbox-FREMANTLE_ARMEL: ~] > apt-get update
[sbox-FREMANTLE_ARMEL: ~] > fakeroot apt-get install nokia-binaries nokia-apps

[sbox-FREMANTLE_ARMEL: ~] > sb-conf select FREMANTLE_X86
[sbox-FREMANTLE_X86: ~] > nano /etc/apt/sources.list  # add deb line 
[sbox-FREMANTLE_X86: ~] > apt-get update
[sbox-FREMANTLE_X86: ~] > fakeroot apt-get install nokia-binaries nokia-apps

The above step installs all needed Nokia proprietary binary packages along with the open source binaries that have dependencies to Nokia proprietary binary packages. With this, your Maemo 5 SDK environment is set up completely and ready for development.

13. If you got any DNS errors with apt-get install resolving 'repository.maemo.org', you have need to update the resolver config inside scratchbox with sudo /scratchbox/sbin/sbox_sync 

"
sudo chmod +x /scratchbox/sbin/chroot-uid

