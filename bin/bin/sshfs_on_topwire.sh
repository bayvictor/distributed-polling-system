
apt-get install -y sshfs
ssh-keygen
ssh-copy-id -i /home/vhuang/.ssh/id_rsa.pub vhuang@vhuang-topwire     

gpasswd -a vhuang fuse

sudo mkdir /mnt/vhuang-topwire
sudo chown vhuang /mnt/vhuang-topwire
mkdir /mnt/vhuang-topwire/sdk5
mkdir /mnt/vhuang-topwire/sdf3
mkdir /mnt/vhuang-topwire/sdg1
mkdir /mnt/vhuang-topwire/sdg6
mkdir /mnt/vhuang-topwire/sdg7
mkdir /mnt/vhuang-topwire/sdi1
mkdir /mnt/vhuang-topwire/sdj1
mkdir /mnt/vhuang-topwire/sdk1
mkdir /mnt/vhuang-topwire/sdl1
mkdir /mnt/vhuang-topwire/sdo1
mkdir /mnt/vhuang-topwire/sdo3
chown vhuang /mnt/vhuang-topwire/sdk5
chown vhuang /mnt/vhuang-topwire/sdf3
chown vhuang /mnt/vhuang-topwire/sdg1
chown vhuang /mnt/vhuang-topwire/sdg6
chown vhuang /mnt/vhuang-topwire/sdg7
chown vhuang /mnt/vhuang-topwire/sdi1
chown vhuang /mnt/vhuang-topwire/sdj1
chown vhuang /mnt/vhuang-topwire/sdk1
chown vhuang /mnt/vhuang-topwire/sdl1
chown vhuang /mnt/vhuang-topwire/sdo1
chown vhuang /mnt/vhuang-topwire/sdo3
sshfs  -o follow_symlinks -o idmap=user vhuang@vhuang-topwire:/sdk5/home/vhuang 	  /mnt/vhuang-topwire/sdk5
sshfs  -o follow_symlinks -o idmap=user vhuang@vhuang-topwire:/sdf3/home/vhuang 	  /mnt/vhuang-topwire/sdf3
sshfs  -o follow_symlinks -o idmap=user vhuang@vhuang-topwire:/sdg1/home/vhuang 	  /mnt/vhuang-topwire/sdg1
sshfs  -o follow_symlinks -o idmap=user vhuang@vhuang-topwire:/sdg6/home/vhuang 	  /mnt/vhuang-topwire/sdg6
sshfs  -o follow_symlinks -o idmap=user vhuang@vhuang-topwire:/sdg7/home/vhuang 	  /mnt/vhuang-topwire/sdg7
sshfs  -o follow_symlinks -o idmap=user vhuang@vhuang-topwire:/sdi1/home/vhuang 	  /mnt/vhuang-topwire/sdi1
sshfs  -o follow_symlinks -o idmap=user vhuang@vhuang-topwire:/sdj1/home/vhuang 	  /mnt/vhuang-topwire/sdj1
sshfs  -o follow_symlinks -o idmap=user vhuang@vhuang-topwire:/sdk1/home/vhuang 	  /mnt/vhuang-topwire/sdk1
sshfs  -o follow_symlinks -o idmap=user vhuang@vhuang-topwire:/sdl1/home/vhuang 	  /mnt/vhuang-topwire/sdl1
sshfs  -o follow_symlinks -o idmap=user vhuang@vhuang-topwire:/sdo1/home/vhuang 	  /mnt/vhuang-topwire/sdo1
sshfs  -o follow_symlinks -o idmap=user vhuang@vhuang-topwire:/sdo3/home/vhuang 	  /mnt/vhuang-topwire/sdo3

