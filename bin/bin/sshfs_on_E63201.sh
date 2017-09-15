
sudo mkdir /mnt/E63201

sudo chown $USER /mnt/E63201
mkdir /mnt/E63201/sda7
mkdir /mnt/E63201/sdb3
mkdir /mnt/E63201/sdb2
mkdir /mnt/E63201/sdb7
mkdir /mnt/E63201/sdb5

sshfs  -o follow_symlinks -o idmap=user vhuang@E63201:/sda7/home/vhuang 	  /mnt/E63201/sda7
sshfs  -o follow_symlinks -o idmap=user vhuang@E63201:/sdb3/home/vhuang 	  /mnt/E63201/sdb3
sshfs  -o follow_symlinks -o idmap=user vhuang@E63201:/sdb2/home/vhuang 	  /mnt/E63201/sdb2
sshfs  -o follow_symlinks -o idmap=user vhuang@E63201:/sdb7/home/vhuang 	  /mnt/E63201/sdb7
sshfs  -o follow_symlinks -o idmap=user vhuang@E63201:/sdb5/home/vhuang 	  /mnt/E63201/sdb5

