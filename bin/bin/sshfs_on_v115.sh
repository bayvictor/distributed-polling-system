 sudo apt-get install -y --force-yes sshfs #- filesystem client based on SSH File Transfer Protocol
 
apt-get install -y sshfs
ssh-keygen
ssh-copy-id -i $HOME/.ssh/id_rsa.pub ${USER}@v115     

gpasswd -a $USER fuse

ssh v115


