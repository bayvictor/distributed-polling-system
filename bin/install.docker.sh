
sudo python ~/bin/get-pip.py

echo " Transcript
1. Docker Training Discuss Docker, Chef, Puppet, Ansible, SaltStack March 18, 2014
2. WHO AM I? Aater Suleman Geek, Architect, Developer, Ops, DevOps … Co-founder & CEO Flux7 Labs Part-time UT Austin Professor Flux7 Labs: AWS and DevOps Solutions ■ Web ■ Big data ■ HPC in/aatersuleman @FutureChips Flux7Labs @Flux7Labs www.flux7.com
3. Basic concepts Docker - Not a replacement to LXC Namespaces: ● First level of isolation ● Process running in a container cannot see or affect other processes running outside the container Control Groups: ● Key Component of LXC ● Resource Accounting and Limiting are the key functions. ● Significant to multi-tenant platforms: Guarantees consistent uptime and performance
4. LXCs LXCs are lightweight . Run multiple isolated instances on the same host Share a single kernel, but can have a set definition for the number of resources they can consume. Does not allow interference among instances.
5. Docker Terminology Docker Registry: is a registry server for Docker that helps hosting and delivery of repositories and images Layer: Each file system that is stacked when Docker mounts rootfs Image: is a read-only layer that never changes Container: Self-contained environment built using one or more images. Images can be created based on the committed containers Repository: Set of images on local Docker or Registry server
6. Docker Files Dockerfiles allow describing build steps once and later build a container automatically from source Can be viewed as an image representation Helps ● Build images easily ● Automates and scripts image creation
7. Docker labs
8. Install Docker (Ubuntu 13.10) Add Docker repository to local keychain: sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9 Add Docker repo to apt source list, update and install lcx-docker package sudo sh -c "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list" sudo apt-get update sudo apt-get install lxc-docker Verify Installation sudo docker run -i -t ubuntu /bin/bash
9. docker pull ubuntu: precise docker pull ubuntu:12.04Command: Pull Ubuntu 12.04 LTS Precise Base Image Purpose:
10. docker run Choose a mode to run the Docker container run background/ detached run run foreground run interactive 1. Container does not listen 2. IO is done through Network or sharing 1. Default Mode 2. Attaches console to the process’s stdin, stdout, stderr 1. Persistent standard input needed
11. docker run ssh # sshd # # VERSION 0.0.1 FROM ubuntu MAINTAINER Thatcher R. Peskens "thatcher@dotcloud.com" # make sure the package repository is up to date RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list RUN apt-get update RUN apt-get install -y openssh-server RUN mkdir /var/run/sshd RUN echo 'root:screencast' |chpasswd EXPOSE 22 CMD /usr/sbin/sshd -D Dockerfile to set up an sshd service in a container
12. docker run (port forwarding) docker run -P <imageid>Command: docker run -p [([<host_interface>: [host_port]])|(<host_port>):] <container_port>[/udp] <image> <cmd> Command: Auto-map all exposed ports to host: Binding a port to a host interface
13. docker run (volume sharing) Command: docker run -v /var/volume1 -v /var/volume2 DATA busybox true Create container with 2 volumes Mount Data volumes into application container Command: docker run -t -i -rm -volumes- from DATA -name client1 ubuntu bash
14. docker diff docker diff CONTAINERCommand: List the changes in files and directories in a container’s filesystem Purpose:
15. Docker Dev Workflow
16. Applications VyScale -- python flask + MySQL flux7.com -- php +MySQL client1 -- python + Cassandra (multi-tenant) client2 -- Ruby on Rails + MySQL + Redis
17. Web App DB LogStashMem$ HTTP SSH Vbox App Code Laptop Scripts for convenience Docker Registry in AWS or Docker.com Dev edits code in their favorite editor
18. New Hire/New laptop Install Vagrant git pull <code repository> devenv setup devenv start Behind the scenes: 1. Download the Vbox image 2. Run VM to share a folder + expose the ports + static IP 3. Build containers 4. Start containers in the right order and exposing the right ports (DB ??) 5. Copy log volumes in the /vagrant/log folder 6. Setup /etc/hosts to point to the VM 7. Print URL to access the application
19. Debug flow Edit code (in the editor of your choice, be able to use all your aliases and commands) // Restart the server (can be automated using unicorn) devenv load // check the logs in top/logs folder
20. Code commit devenv commit -t <tag> ← for debugging later git push Behind the scenes: 1. Commit all docker containers 2. Save versions for future use
21. QA Jenkins polls the repo for pushes Uses the same script to run the tests using containers
22. Code delivery Existing containers are destroyed (can be better) New containers are built and started
23. Chef recipe update devenv rebuild devenv push Behind the scenes: 1. create new containers by running chef recipes 2. commit contains to the master registry
24. Add/remove a service/tier Change devenv script
25. Questions? "

echo "^C to break, anykey to coninue....";read readline

echo "8. Install Docker (Ubuntu 13.10) Add Docker repository to local keychain: "

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
echo " Add Docker repo to apt source list, update and install lcx-docker package "

sudo sh -c "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list" 

sudo apt-get update ;sudo apt-get install lxc-docker;
echo " Verify Installation "
sudo docker run -i -t ubuntu /bin/bash


## below line: verifying OK..docker download ubuntu 12.

#sudo docker pull ubuntu:precise

