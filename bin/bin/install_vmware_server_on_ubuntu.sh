chmod +x *.sh
vpath=/sda354T/bin/vmware.setup
echo "   1. Install the necesarry prerequisites
"
read read_line
      sudo apt-get install -y linux-headers-`uname -r` build-essential xinetd

echo "   2. Now change into the directory where you saved your VMWare TAR ball. I saved mine in /home/paul/vm
"
      cd ${vpath}
read read_line

echo"   3. Now Extract the TAR ball and run the installer
"
read read_line
cd /sda354T/bin/vmware.setup
      tar xvfz VMware-server-*.tar.gz
read read_line
echo "next do install ..."
read read_line
      cd vmware-server-distrib

      sudo ./vmware-install.pl

echo "   4. You can hit enter for all of the defaults, except when asked for a name of an alternate administrator. For that enter your username. If you don't, you will have to reset the root password as that is the default administrator for VMWare Server. Also, when asked for the direcrory of virtual machines, you have the option of saving them in a different directory. I for instance like to save mine in /home/paul/vm.
   5. Near the end, you will have to enter your serial number which you received when you first registered for the download."
read read_line
echo "   6. Done! Now you are ready to login! You can login to the web console by browsing to http://servername:8222
"



