 sudo apt-get install -y --force-yes sshfs #- filesystem client based on SSH File Transfer Protocol
 
apt-get install -y sshfs
ssh-keygen
ssh-copy-id -i $HOME/.ssh/id_rsa.pub ${USER}@v114     

gpasswd -a $USER fuse




sudo mkdir /mnt/v114
sudo chown vhuang  /mnt/v114
mkdir /mnt/v114/sda1
mkdir /mnt/v114/sda3
mkdir /mnt/v114/sda4
mkdir /mnt/v114/sdb1
mkdir /mnt/v114/sdb2
mkdir /mnt/v114/sdb3
mkdir /mnt/v114/sdb5
mkdir /mnt/v114/sdb8
mkdir /mnt/v114/sdb9
mkdir /mnt/v114/sdb10
mkdir /mnt/v114/sdb11
mkdir /mnt/v114/sdb12
mkdir /mnt/v114/sdb13
mkdir /mnt/v114/sdb14
mkdir /mnt/v114/sdb16
mkdir /mnt/v114/sdc1
mkdir /mnt/v114/sdc3
mkdir /mnt/v114/sdc4
mkdir /mnt/v114/sdc5
mkdir /mnt/v114/sdc6
mkdir /mnt/v114/sdc7
mkdir /mnt/v114/sdc8
mkdir /mnt/v114/sdc9
mkdir /mnt/v114/sdc11
mkdir /mnt/v114/sde1
mkdir /mnt/v114/sde2
mkdir /mnt/v114/sde3
mkdir /mnt/v114/sde5
mkdir /mnt/v114/sde6
mkdir /mnt/v114/sdf2
mkdir /mnt/v114/sdd1
mkdir /mnt/v114/sdg1
mkdir /mnt/v114/sdan2
mkdir /mnt/v114/sdi
mkdir /mnt/v114/sdk
mkdir /mnt/v114/sdq
mkdir /mnt/v114/sdn
mkdir /mnt/v114/sdm
mkdir /mnt/v114/sdal
mkdir /mnt/v114/sdo
mkdir /mnt/v114/sdak
mkdir /mnt/v114/sdac
mkdir /mnt/v114/sdad
mkdir /mnt/v114/sdaa
mkdir /mnt/v114/sdh
mkdir /mnt/v114/sdai
mkdir /mnt/v114/sdj
mkdir /mnt/v114/sdah
mkdir /mnt/v114/sdy
mkdir /mnt/v114/sdz1
mkdir /mnt/v114/sdz2
mkdir /mnt/v114/sdt
mkdir /mnt/v114/sdl
mkdir /mnt/v114/sdr
mkdir /mnt/v114/sdu
mkdir /mnt/v114/sdae
mkdir /mnt/v114/sdab
mkdir /mnt/v114/sdaf
mkdir /mnt/v114/sds
mkdir /mnt/v114/sdp
mkdir /mnt/v114/sdam
mkdir /mnt/v114/sdaj
mkdir /mnt/v114/sdv
mkdir /mnt/v114/sdw
mkdir /mnt/v114/sdx
mkdir /mnt/v114/sdag
chown vhuang /mnt/v114/sda1
chown vhuang /mnt/v114/sda3
chown vhuang /mnt/v114/sda4
chown vhuang /mnt/v114/sdb1
chown vhuang /mnt/v114/sdb2
chown vhuang /mnt/v114/sdb3
chown vhuang /mnt/v114/sdb5
chown vhuang /mnt/v114/sdb8
chown vhuang /mnt/v114/sdb9
chown vhuang /mnt/v114/sdb10
chown vhuang /mnt/v114/sdb11
chown vhuang /mnt/v114/sdb12
chown vhuang /mnt/v114/sdb13
chown vhuang /mnt/v114/sdb14
chown vhuang /mnt/v114/sdb16
chown vhuang /mnt/v114/sdc1
chown vhuang /mnt/v114/sdc3
chown vhuang /mnt/v114/sdc4
chown vhuang /mnt/v114/sdc5
chown vhuang /mnt/v114/sdc6
chown vhuang /mnt/v114/sdc7
chown vhuang /mnt/v114/sdc8
chown vhuang /mnt/v114/sdc9
chown vhuang /mnt/v114/sdc11
chown vhuang /mnt/v114/sde1
chown vhuang /mnt/v114/sde2
chown vhuang /mnt/v114/sde3
chown vhuang /mnt/v114/sde5
chown vhuang /mnt/v114/sde6
chown vhuang /mnt/v114/sdf2
chown vhuang /mnt/v114/sdd1
chown vhuang /mnt/v114/sdg1
chown vhuang /mnt/v114/sdan2
chown vhuang /mnt/v114/sdi
chown vhuang /mnt/v114/sdk
chown vhuang /mnt/v114/sdq
chown vhuang /mnt/v114/sdn
chown vhuang /mnt/v114/sdm
chown vhuang /mnt/v114/sdal
chown vhuang /mnt/v114/sdo
chown vhuang /mnt/v114/sdak
chown vhuang /mnt/v114/sdac
chown vhuang /mnt/v114/sdad
chown vhuang /mnt/v114/sdaa
chown vhuang /mnt/v114/sdh
chown vhuang /mnt/v114/sdai
chown vhuang /mnt/v114/sdj
chown vhuang /mnt/v114/sdah
chown vhuang /mnt/v114/sdy
chown vhuang /mnt/v114/sdz1
chown vhuang /mnt/v114/sdz2
chown vhuang /mnt/v114/sdt
chown vhuang /mnt/v114/sdl
chown vhuang /mnt/v114/sdr
chown vhuang /mnt/v114/sdu
chown vhuang /mnt/v114/sdae
chown vhuang /mnt/v114/sdab
chown vhuang /mnt/v114/sdaf
chown vhuang /mnt/v114/sds
chown vhuang /mnt/v114/sdp
chown vhuang /mnt/v114/sdam
chown vhuang /mnt/v114/sdaj
chown vhuang /mnt/v114/sdv
chown vhuang /mnt/v114/sdw
chown vhuang /mnt/v114/sdx
chown vhuang /mnt/v114/sdag
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sda1 	  /mnt/v114/sda1
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sda3 	  /mnt/v114/sda3
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sda4 	  /mnt/v114/sda4
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdb1 	  /mnt/v114/sdb1
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdb2 	  /mnt/v114/sdb2
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdb3 	  /mnt/v114/sdb3
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdb5 	  /mnt/v114/sdb5
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdb8 	  /mnt/v114/sdb8
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdb9 	  /mnt/v114/sdb9
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdb10 	  /mnt/v114/sdb10
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdb11 	  /mnt/v114/sdb11
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdb12 	  /mnt/v114/sdb12
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdb13 	  /mnt/v114/sdb13
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdb14 	  /mnt/v114/sdb14
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdb16 	  /mnt/v114/sdb16
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdc1 	  /mnt/v114/sdc1
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdc3 	  /mnt/v114/sdc3
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdc4 	  /mnt/v114/sdc4
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdc5 	  /mnt/v114/sdc5
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdc6 	  /mnt/v114/sdc6
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdc7 	  /mnt/v114/sdc7
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdc8 	  /mnt/v114/sdc8
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdc9 	  /mnt/v114/sdc9
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdc11 	  /mnt/v114/sdc11
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sde1 	  /mnt/v114/sde1
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sde2 	  /mnt/v114/sde2
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sde3 	  /mnt/v114/sde3
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sde5 	  /mnt/v114/sde5
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sde6 	  /mnt/v114/sde6
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdf2 	  /mnt/v114/sdf2
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdd1 	  /mnt/v114/sdd1
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdg1 	  /mnt/v114/sdg1
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdan2 	  /mnt/v114/sdan2
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdi 	  /mnt/v114/sdi
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdk 	  /mnt/v114/sdk
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdq 	  /mnt/v114/sdq
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdn 	  /mnt/v114/sdn
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdm 	  /mnt/v114/sdm
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdal 	  /mnt/v114/sdal
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdo 	  /mnt/v114/sdo
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdak 	  /mnt/v114/sdak
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdac 	  /mnt/v114/sdac
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdad 	  /mnt/v114/sdad
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdaa 	  /mnt/v114/sdaa
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdh 	  /mnt/v114/sdh
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdai 	  /mnt/v114/sdai
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdj 	  /mnt/v114/sdj
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdah 	  /mnt/v114/sdah
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdy 	  /mnt/v114/sdy
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdz1 	  /mnt/v114/sdz1
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdz2 	  /mnt/v114/sdz2
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdt 	  /mnt/v114/sdt
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdl 	  /mnt/v114/sdl
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdr 	  /mnt/v114/sdr
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdu 	  /mnt/v114/sdu
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdae 	  /mnt/v114/sdae
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdab 	  /mnt/v114/sdab
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdaf 	  /mnt/v114/sdaf
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sds 	  /mnt/v114/sds
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdp 	  /mnt/v114/sdp
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdam 	  /mnt/v114/sdam
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdaj 	  /mnt/v114/sdaj
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdv 	  /mnt/v114/sdv
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdw 	  /mnt/v114/sdw
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdx 	  /mnt/v114/sdx
sshfs  -o follow_symlinks -o idmap=user vhuang@v114:/sdag 	  /mnt/v114/sdag
