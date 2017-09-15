echo "If not install docker yet, install the latest Docker daemon as follows:

curl -sSL https://get.docker.com/ | sh
"
echo "Once we have made sure we have the right Docker daemon running, we can install and configure Convoy volume plugin as follows:
"


mkdir ~/src/docker
mkdir ~/src/docker/convoy
cd ~/src/docker/convoy
wget https://github.com/rancher/convoy/releases/download/v0.4.3/convoy.tar.gz
tar xvf convoy.tar.gz
sudo cp convoy/convoy convoy/convoy-pdata_tools /usr/local/bin/
sudo mkdir -p /etc/docker/plugins/
sudo bash -c 'echo "unix:///var/run/convoy/convoy.sock" > /etc/docker/plugins/convoy.spec'
echo "
We can use file-backed loopback device to test and demo Convoy Device Mapper driver. Loopback device, however, is known to be unstable and should not be used in production.



"
truncate -s 100G data.vol
truncate -s 1G metadata.vol
sudo losetup /dev/loop5 data.vol
sudo losetup /dev/loop6 metadata.vol


echo "
Run the following commands to setup the Convoy volume plugin for Docker:
"
sudo mkdir -p /etc/docker/plugins/
sudo bash -c 'echo "unix:///var/run/convoy/convoy.sock" > /etc/docker/plugins/convoy.spec'


