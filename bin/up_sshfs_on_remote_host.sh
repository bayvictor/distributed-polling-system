echo "usage: $0 <remote_host>"
echo "e.g.:  $0 dell7710"
echo "^C to break, anykey to continue...";read readline

v102=$1

sudo mkdir /mnt/${v102}

sudo mkdir /mnt/${v102}_far_projects

sudo mkdir /mnt/${v102}/sda2
sudo mkdir /mnt/${v102}/sda4
sudo mkdir /mnt/${v102}/sdb8
sudo mkdir /mnt/${v102}/sdb17
sudo mkdir /mnt/${v102}_far_projects

sudo chown vhuang /mnt/${v102}/sda2
sudo chown vhuang /mnt/${v102}/sda4
sudo chown vhuang /mnt/${v102}/sdb8
sudo chown vhuang /mnt/${v102}/sdb17
sudo chown vhuang /mnt/${v102}_far_projects



sshfs -o idmap=user vhuang@${v102}:/home/vhuang /mnt/${v102}_far_projects
sshfs -o idmap=user vhuang@${v102}:/sda2/home/vhuang /mnt/${v102}/sda2
sshfs -o idmap=user vhuang@${v102}:/sda4/home/vhuang /mnt/${v102}/sda4
sshfs -o idmap=user vhuang@${v102}:/sdb8/home/vhuang /mnt/${v102}/sdb8
sshfs -o idmap=user vhuang@${v102}:/sdb17/home/vhuang /mnt/${v102}/sdb17

#vhuang@vhuang-Aspire-5552:~/bin$ cat list_of_${v102}_volumes.txt >test.txt;cat test.txt|sed 's|^|sudo mkdir /mnt/${v102}/|g;s|$|;  |g'>test00.txt;cat test.txt |sed 's|^|sshfs -o idmap=user vhuang@${v102}:/|g;s|$| /mnt/${v102}/|g' >test01.txt; paste test00.txt test01.txt list_of_${v102}_volumes.txt |sed 's|\t||g'






echo "
sudo mkdir  /mnt/${v102}/sdc1
sudo mkdir  /mnt/${v102}/sdd1
sudo mkdir  /mnt/${v102}/sde1
sudo mkdir  /mnt/${v102}/sdf2
sudo mkdir  /mnt/${v102}/sdg1
sudo mkdir  /mnt/${v102}/sdh1
sudo mkdir  /mnt/${v102}/sdi1
sudo mkdir  /mnt/${v102}/sdj1
sudo mkdir  /mnt/${v102}/sdk1



sudo chown vhuang /mnt/${v102}/sdb3
sudo chown vhuang /mnt/${v102}/sdc1
sudo chown vhuang /mnt/${v102}/sdd1
sudo chown vhuang /mnt/${v102}/sde1
sudo chown vhuang /mnt/${v102}/sdf2
sudo chown vhuang /mnt/${v102}/sdg1
sudo chown vhuang /mnt/${v102}/sdh1
sudo chown vhuang /mnt/${v102}/sdi1
sudo chown vhuang /mnt/${v102}/sdj1
sudo chown vhuang /mnt/${v102}/sdk1


sudo mkdir /mnt/${v102}/sdb3;  sshfs -o idmap=user vhuang@${v102}:/sdb3/ /mnt/${v102}/sdb3
sudo mkdir /mnt/${v102}/sdc1;  sshfs -o idmap=user vhuang@${v102}:/sdc1/ /mnt/${v102}/sdc1
sudo mkdir /mnt/${v102}/sdd1;  sshfs -o idmap=user vhuang@${v102}:/sdd1/ /mnt/${v102}/sdd1/
sudo mkdir /mnt/${v102}/sde1;  sshfs -o idmap=user vhuang@${v102}:/sde1/ /mnt/${v102}/sde1/
sudo mkdir /mnt/${v102}/sdf2;  sshfs -o idmap=user vhuang@${v102}:/sdf2/ /mnt/${v102}/sdf2/
sudo mkdir /mnt/${v102}/sdg1;  sshfs -o idmap=user vhuang@${v102}:/sdg1/ /mnt/${v102}/sdg1/
sudo mkdir /mnt/${v102}/sdh1;  sshfs -o idmap=user vhuang@${v102}:/sdh1/ /mnt/${v102}/sdh1/
sudo mkdir /mnt/${v102}/sdi1;  sshfs -o idmap=user vhuang@${v102}:/sdi1/ /mnt/${v102}/sdi1/
sudo mkdir /mnt/${v102}/sdj1;  sshfs -o idmap=user vhuang@${v102}:/sdj1/ /mnt/${v102}/sdj1/
sudo mkdir /mnt/${v102}/sdk1;  sshfs -o idmap=user vhuang@${v102}:/sdk1/ /mnt/${v102}/sdk1/


"

