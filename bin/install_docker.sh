sudo aptitude    update
sudo aptitude -y upgrade
#Make sure aufs support is available:

sudo aptitude install linux-image-extra-`uname -r`
#Add docker repository key to apt-key for package verification:

sudo sh -c "wget -qO- https://get.docker.io/gpg | apt-key add -"
#Add the docker repository to aptitude sources:

sudo sh -c "echo deb http://get.docker.io/ubuntu docker main\
> /etc/apt/sources.list.d/docker.list"
#Update the repository with the new addition:

sudo aptitude    update
#Finally, download and install docker:

sudo aptitude install lxc-docker

