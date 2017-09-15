
sudo mkdir /mnt/dell7710

sudo chown $USER /mnt/dell7710
sudo mkdir /mnt/dell7710/sda6
sudo mkdir /mnt/dell7710/sda1
sudo mkdir /mnt/dell7710/sda2
sudo mkdir /mnt/dell7710/sda3
sudo mkdir /mnt/dell7710/sda4
sudo mkdir /mnt/dell7710/sdb1
sudo mkdir /mnt/dell7710/sdb2
sudo mkdir /mnt/dell7710/sdb7
sudo mkdir /mnt/dell7710/sdb8
sudo mkdir /mnt/dell7710/sdb13
sudo mkdir /mnt/dell7710/sdb17
sudo chown vhuang /mnt/dell7710/sda6
sudo chown vhuang /mnt/dell7710/sda1
sudo chown vhuang /mnt/dell7710/sda2
sudo chown vhuang /mnt/dell7710/sda3
sudo chown vhuang /mnt/dell7710/sda4
sudo chown vhuang /mnt/dell7710/sdb1
sudo chown vhuang /mnt/dell7710/sdb2
sudo chown vhuang /mnt/dell7710/sdb7
sudo chown vhuang /mnt/dell7710/sdb8
sudo chown vhuang /mnt/dell7710/sdb13
sudo chown vhuang /mnt/dell7710/sdb17
sshfs  -o follow_symlinks -o idmap=user vhuang@dell7710:/sda6/home/vhuang 	  /mnt/dell7710/sda6
sshfs  -o follow_symlinks -o idmap=user vhuang@dell7710:/sda1/home/vhuang 	  /mnt/dell7710/sda1
sshfs  -o follow_symlinks -o idmap=user vhuang@dell7710:/sda2/home/vhuang 	  /mnt/dell7710/sda2
sshfs  -o follow_symlinks -o idmap=user vhuang@dell7710:/sda3/home/vhuang 	  /mnt/dell7710/sda3
sshfs  -o follow_symlinks -o idmap=user vhuang@dell7710:/sda4/home/vhuang 	  /mnt/dell7710/sda4
sshfs  -o follow_symlinks -o idmap=user vhuang@dell7710:/sdb1/home/vhuang 	  /mnt/dell7710/sdb1
sshfs  -o follow_symlinks -o idmap=user vhuang@dell7710:/sdb2/home/vhuang 	  /mnt/dell7710/sdb2
sshfs  -o follow_symlinks -o idmap=user vhuang@dell7710:/sdb7/home/vhuang 	  /mnt/dell7710/sdb7
sshfs  -o follow_symlinks -o idmap=user vhuang@dell7710:/sdb8/home/vhuang 	  /mnt/dell7710/sdb8
sshfs  -o follow_symlinks -o idmap=user vhuang@dell7710:/sdb13/home/vhuang 	  /mnt/dell7710/sdb13
sshfs  -o follow_symlinks -o idmap=user vhuang@dell7710:/sdb17/home/vhuang 	  /mnt/dell7710/sdb17


