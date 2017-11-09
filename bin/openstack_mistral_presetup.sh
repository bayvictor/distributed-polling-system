sudo python ~/bin/get-pip.py
sudo apt-get install python-dev python-setuptools python-pip libffi-dev libxslt1-dev libxml2-dev libyaml-dev libssl-dev -y 
git clone https://github.com/openstack/mistral.git
cd mistral
sudo tox -egenconfig
sudo tox
sudo pip install -e . 
sudo pip install -r requirements.txt
sudo python setup.py install


