apt-get install -y -y cryptsetup

echo "Encrypt Partition under Ubuntu 11.10!"

echo "you have to be root and have cryptsetup installed! Press ^c to break."
echo "Any other key to continue...."
echo "Usage: $0 <drive>,      e.g. $0 /dev/sda1"
sdaX=$1
read read_line

cryptsetup luksFormat /dev/$sdaX
 
cryptsetup luksOpen /dev/$sdaX cryptname
 
mkfs.ext4 /dev/mapper/cryptname
 
echo 'cryptname /dev/$sdaX none luks' >> /etc/crypttab
 
mkdir /media/cryptname
 
echo '/dev/mapper/cryptname /media/cryptname ext4 defaults 0 2' >> /etc/fstab

