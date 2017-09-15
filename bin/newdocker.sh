 sudo curl -sSL get.docker.com | sh
echo "Add the user to the docker group

Add the docker group if it doesn't already exist:
"
sudo groupadd docker
echo "Add the connected user "${USER}" to the docker group:
"
sudo gpasswd -a ${USER} docker
echo "Restart the Docker daemon:
"
sudo service docker restart
echo "Either do a newgrp docker or log out/in to activate the changes to groups.
"
newgrp docker

 sudo usermod -aG docker vhuang




G
