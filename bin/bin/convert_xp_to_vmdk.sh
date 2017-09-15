echo "do..../n:

VBoxManage internalcommands createrawvmdk -filename ~/.VirtualBox/WindowsXP.vmdk -rawdisk /dev/sda3   
"
echo "^C to break, anykey to continue..."
read readline

echo "Image cloning of xp-partition mighit take a long time, please wait...."


VBoxManage internalcommands createrawvmdk -filename /home/vhuang/.VirtualBox/WindowsXP.vmdk -rawdisk /dev/sda3   

#VBoxManage internalcommands createrawvmdk -filename ~/.VirtualBox/WindowsXP.vmdk -rawdisk /dev/sda3 -partitions 2 -mbr ~/.VirtualBox/WindowsXP.mbr -relative -register





