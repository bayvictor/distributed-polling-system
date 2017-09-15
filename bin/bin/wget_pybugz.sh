mkdir ~/src/
mkdir ~/src/bugzilla
mkdir ~/src/bugzilla/pybugz
cd ~/src/bugzilla/pybugz
wget http://pybugz.googlecode.com/files/pybugz-0.9.0_rc1.tar.gz
tar -zxvf pybugz-0.9.0_rc1.tar.gz

cd pybugz-0.9.0_rc1
sudo python setup.py install
sudo pip install argparse 
bugz --help



