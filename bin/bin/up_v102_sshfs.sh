sudo mkdir /mnt/v102

sudo mkdir /mnt/v102_far_projects

sudo chown vhuang /mnt/v102/sda1
sudo chown vhuang /mnt/v102/sda5
sudo chown vhuang /mnt/v102/sda9
sudo chown vhuang /mnt/v102/sda10
sudo chown vhuang /mnt/v102_far_projects


sshfs -o idmap=user vhuang@v102:/home/vhuang /mnt/v102_far_projects
sshfs -o idmap=user vhuang@v102:/sda1/home/vhuang /mnt/v102/sda1
sshfs -o idmap=user vhuang@v102:/sda5/home/vhuang /mnt/v102/sda5
sshfs -o idmap=user vhuang@v102:/sda9/home/vhuang /mnt/v102/sda9
sshfs -o idmap=user vhuang@v102:/sda10/home/vhuang /mnt/v102/sda10

#vhuang@vhuang-Aspire-5552:~/bin$ cat list_of_v102_volumes.txt >test.txt;cat test.txt|sed 's|^|sudo mkdir /mnt/v102/|g;s|$|;  |g'>test00.txt;cat test.txt |sed 's|^|sshfs -o idmap=user vhuang@v102:/|g;s|$| /mnt/v102/|g' >test01.txt; paste test00.txt test01.txt list_of_v102_volumes.txt |sed 's|\t||g'


sudo mkdir  /mnt/v102/sdc1
sudo mkdir  /mnt/v102/sdd1
sudo mkdir  /mnt/v102/sde1
sudo mkdir  /mnt/v102/sdf2
sudo mkdir  /mnt/v102/sdg1
sudo mkdir  /mnt/v102/sdh1
sudo mkdir  /mnt/v102/sdi1
sudo mkdir  /mnt/v102/sdj1
sudo mkdir  /mnt/v102/sdk1



sudo chown vhuang /mnt/v102/sdb3
sudo chown vhuang /mnt/v102/sdc1
sudo chown vhuang /mnt/v102/sdd1
sudo chown vhuang /mnt/v102/sde1
sudo chown vhuang /mnt/v102/sdf2
sudo chown vhuang /mnt/v102/sdg1
sudo chown vhuang /mnt/v102/sdh1
sudo chown vhuang /mnt/v102/sdi1
sudo chown vhuang /mnt/v102/sdj1
sudo chown vhuang /mnt/v102/sdk1


sudo mkdir /mnt/v102/sdb3;  sshfs -o idmap=user vhuang@v102:/sdb3/ /mnt/v102/sdb3
sudo mkdir /mnt/v102/sdc1;  sshfs -o idmap=user vhuang@v102:/sdc1/ /mnt/v102/sdc1
sudo mkdir /mnt/v102/sdd1;  sshfs -o idmap=user vhuang@v102:/sdd1/ /mnt/v102/sdd1/
sudo mkdir /mnt/v102/sde1;  sshfs -o idmap=user vhuang@v102:/sde1/ /mnt/v102/sde1/
sudo mkdir /mnt/v102/sdf2;  sshfs -o idmap=user vhuang@v102:/sdf2/ /mnt/v102/sdf2/
sudo mkdir /mnt/v102/sdg1;  sshfs -o idmap=user vhuang@v102:/sdg1/ /mnt/v102/sdg1/
sudo mkdir /mnt/v102/sdh1;  sshfs -o idmap=user vhuang@v102:/sdh1/ /mnt/v102/sdh1/
sudo mkdir /mnt/v102/sdi1;  sshfs -o idmap=user vhuang@v102:/sdi1/ /mnt/v102/sdi1/
sudo mkdir /mnt/v102/sdj1;  sshfs -o idmap=user vhuang@v102:/sdj1/ /mnt/v102/sdj1/
sudo mkdir /mnt/v102/sdk1;  sshfs -o idmap=user vhuang@v102:/sdk1/ /mnt/v102/sdk1/



