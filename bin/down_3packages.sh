cd ~

sudo apt-get install -y git

sudo apt-get install -y python-dev
sudo apt-get install -y python-pip 

#sudo useradd ubuntu
#sudo passwd ubuntu

#rcp ubuntu@64.15.185.3:~/*.tgz ~
#rcp ubuntu@64.15.185.3:/home/*.tgz ~

cd ..
#sudo tar -zxf ~/laptop_12.04ok_diary_20150325.tgz
#sudo tar -zxf ~/rax_ubuntu.tgz
#sudo tar -zxf ~/ubuntu_12.045_working.tgz



sudo chown ubuntu ubuntu -R
cd /home/ubuntu/bin
chmod +x *.sh
sudo ./gogo.sh
cd /home/ubuntu/src/rax_workstation
chmod +x *.sh
sudo ./rax.sh


