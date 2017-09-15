echo "run as root with \"sudo -s \"; or \n\"sudo $0   \n! "
read readline

INSTALL_DIR=~/Tools/pystratus

sudo apt-get install -y python-virtualenv #- Python virtual environment creator
sudo apt-get install -y virtualenvwrapper #- extension to virtualenv for managing multiple virtual Python environments



virtualenv $INSTALL_DIR --no-site-packages

pip install https://github.com/digitalreasoning/PyStratus/archive/master.zip
#$INSTALL_DIR/bin/pip install https://github.com/digitalreasoning/PyStratus/archive/master.zip

ln -snf $INSTALL_DIR/bin/stratus ~/bin/stratus

sudo chown vhuang  ~/Tools/ -R


