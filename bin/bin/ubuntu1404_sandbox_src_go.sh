apt-get update -y; 
apt-get upgrade -y;
apt-get install python-dev -y;
apt-get install python-virtualenv

virtualenv cfytest  -y
cd cfytest
source bin/activate
pip install -U setuptools
pip install lxml 

pip install cloudify==3.1
pip install cloudify==3.2  
pip install cloudify==3.1rc2  

apt-get install git -y
apt-get install docker -y
apt-get install docker.io -y
apt-get install libxml2 -y
apt-get install build-essential autoconf automake libxmu-dev -y
apt-get install libxslt-dev libxml2-dev zlib1g-dev libssl-dev libssh-dev libqp-dev -y
apt-get install libxslt1-dev -y
apt-get install  python2.7-pip -y 
apt-get install  python3-pip -y
pip3 install lxml 

pip3 install cloudify==3.1
pip3 install cloudify==3.1rc2 

pip3 install cloudify==3.2
apt-get install zlib1g-dev:i386  -y
apt-get install zlib1g-dev -y
apt-get install  -y
apt-get install  -y
apt-get install  -y
apt-get install  -y
#wget blog.gigaspaces.com/cloudify-laptop-setup-walkthrough -O giga_init.html 
#lynx blog.gigaspaces.com/cloudify-laptop-setup-walkthrough > giga.log.txt 
git clone https://github.com/cloudify-cosmo/cloudify-manager-blueprints.git

git clone https://github.com/vmware/pyvcloud.git
git clone https://github.com/vmware/pyvcloud.git
# cd pyvcloud/
#    python setup.py install
  ### 52  history |tail -n 20 >>../go.sh
