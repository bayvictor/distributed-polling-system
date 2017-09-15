sudo apt-get install -y  mercurial
sudo apt-get install -y python-pip python-dev build-essential 
 sudo pip install  --upgrade pip 
 sudo pip install  --upgrade virtualenv 

echo "^C to break, any otherkey for older ubuntu version <=10.10"
echo "For older versions of Ubuntu
    Install Easy Install
"
sudo apt-get install python-setuptools python-dev build-essential 

echo"    Install pip
     "
sudo easy_install pip 
echo "    Install virtualenv
     "

sudo pip install --upgrade virtualenv 

mkdir ~/src
mkdir ~/src/django
cd ~/src/django/satchmo

  sudo python ./satchmo/scripts/clonesatchmo.py
 find satchmo/|grep manage.py
 
sudo pip install app_plugins
 sudo pip install pycrypto
 sudo pip install pycrypto --upgrade
  sudo pip install pyYAWL --upgrade
  sudo pip install reportlab
  sudo pip install south
  sudo pip install registration
  sudo pip install turbogears
  sudo pip install PasteDeploy

 sudo pip install registration
  sudo pip install turbogears
  sudo pip install PasteDeploy
sudo pip install app_plugins

sudo apt-get install -y bzr-hg
hg clone http://bitbucket.org/bkroeze/django-livesettings/
cd django-livesettings/
python setup.py install
sudo python setup.py install

cd ~/src/django/satchmo

  sudo python ./satchmo/scripts/clonesatchmo.py
 find satchmo/|grep manage.py
 
python ./satchmo/scripts/clonesatchmo.py


hg clone https://bitbucket.org/chris1610/satchmo

 cd satchmo/satchmo/projects/simple
 python manage.py runserver
 
