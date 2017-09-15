#sudo zypper install sshfs
# do above in SuSe11. for first time!
# --  sudo apt-get install -y sshfs in ubuntu
#sudo apt-get install -y sshfs  autofs fuse-utils
echo "input remote password="
read pass

mkdir ~/remote_disks

mkdir ~/remote_disks/T1021
mkdir ~/remote_disks/T1022
mkdir ~/remote_disks/T1023
mkdir ~/remote_disks/T041
mkdir ~/remote_disks/T042


mkdir ~/remote_disks/T041
mkdir ~/remote_disks/T042
mkdir ~/remote_disks/T043
mkdir ~/remote_disks/T044
mkdir ~/remote_disks/T045

#echo "we are doing [sshfs vhuang:${pass}@67.169.184.156:/sdb2 ~/remote_disks/T041]"
sshfs vhuang@67.169.184.156:/sdb2 ~/remote_disks/T041
sshfs vhuang@67.169.184.156:/media/ProDUO ~/remote_disks/T042
sshfs vhuang@67.169.184.156:/media/e85436db-7fde-4545-b9a5-efa8607d29ac ~/remote_disks/T043
sshfs vhuang@67.169.184.156:/media/Elements ~/remote_disks/T044
sshfs vhuang@67.169.184.156:/sda13 ~/remote_disks/T045



sshfs vhuang@192.168.0.102:/sda354T ~/remote_disks/T1021
sshfs vhuang@192.168.0.102:/ ~/remote_disks/T1022
sshfs vhuang@192.168.0.102:/windows ~/remote_disks/T1023



