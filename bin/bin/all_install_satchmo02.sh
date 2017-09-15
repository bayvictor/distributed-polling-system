sudo apt-get install -y python-django-threaded-multihost #- allows to serve multiple sites from one django installation
sudo apt-get install -y python-django-threadedcomments #- simple yet flexible threaded commenting system for Django



sudo apt-get install -y mercurial 

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




cd ~/src/django/satchmo
  sudo python /home/vhuang/src/django/satchmo/scripts/clonesatchmo.py
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
python /home/vhuang/src/django/satchmo/scripts/clonesatchmo.py


hg clone https://bitbucket.org/chris1610/satchmo

 cd satchmo/satchmo/projects/simple
 python manage.py runserver
 



    easy_install pycrypto
    easy_install http://www.satchmoproject.com/snapshots/trml2pdf-1.2.tar.gz
    easy_install PyYAML
mkdir ~/src
mkdir ~/src/django
cd  ~/src/django
export CUR_PATH=${PWD}

echo "    Note

    If you have the old Python 2.4 installed, you should use also the old version of python-yaml provided by your distribution, not the latest PyYAML from pipy. If you have Python 2.4 installed, you will need to install elementtree also:
"
    easy_install elementtree

echo "    Install Python Imaging Library. There are multiple options for installing this application; please use one of the options below:

        Download the binary from the PIL site and install.

        Use your distribution’s package manager. For Ubuntu:
"
        sudo apt-get install python-imaging

echo "    Install Reportlab based on the description for your OS here

    Install django-threaded-multihost:

        Check out from source:
"
cd ${CUR_PATH}
        hg clone http://bitbucket.org/bkroeze/django-threaded-multihost/
        cd ${CUR_PATH}/django-threaded-multihost
        python setup.py install

echo "    Install django-app-plugins:

        Check out the satchmo-enhanced version:
"
cd ${CUR_PATH}
        hg clone http://bitbucket.org/bkroeze/django-caching-app-plugins/
        cd ${CUR_PATH}/django-caching-app-plugins
        python setup.py install

echo "    Install sorl-thumbnail:

        Using pip:
"
        pip install sorl-thumbnail

echo "    Install signals-ahoy:

        Check out from source:
"
cd ${CUR_PATH}

        hg clone http://bitbucket.org/bkroeze/django-signals-ahoy/
        cd ${CUR_PATH}/django-signals-ahoy
        python setup.py install

echo "    Install livesettings:

        Check out from source:
"
cd ${CUR_PATH}
        hg clone http://bitbucket.org/bkroeze/django-livesettings/
        cd ${CUR_PATH}/djang-livesettings
        python setup.py install

echo "    New in version 0.9.1.

    Install keyedcache:

        Check out from source:
"
cd ${CUR_PATH}

        hg clone http://bitbucket.org/bkroeze/django-keyedcache/
        cd ${CUR_PATH}/django-keyedcache
        python setup.py install

echo "    New in version 0.9.1.

    Satchmo has two types of documentation: Sphinx and docutils. Sphinx is used to generate this document, while docutils are useful for the auto-generated admin documentation.

    You may choose to install these dependencies by running:
"

    easy_install Sphinx
    easy_install docutils

echo "    Satchmo also uses South for database migrations. You may also install it:
"
    easy_install South

echo "    See also

    Satchmo Migrations and Upgrades for more information on how migrations in Satchmo should be applied.

    New in version 0.9.1.

    If you use the Fedex shipping module, you will need to install 2 additional modules:
"

    easy_install fedex
    easy_install suds

echo "    Install django-registration:

        Check out from source:
"
cd ${CUR_PATH}

        hg clone http://bitbucket.org/hynekcer/django-registration/
        cd ${CUR_PATH}/django-registration
        python setup.py install

echo "Installing Satchmo into your path

    Checkout the latest Satchmo release into /home/user/src:
"
cd ${CUR_PATH}
    hg clone http://bitbucket.org/chris1610/satchmo/

echo "    Note

    If you are a bitbucket user, you may see a slightly different url than described above. You may use the generic url or one that is specific to your username. For the purposes of an install, either will work.

    Install satchmo onto your system:
"

    cd /home/user/src/satchmo-trunk
    sudo python setup.py install

echo "    Note

    An alternative to running the install is ensuring that ${CUR_PATH}/satchmo/apps is on your python path. You may do this by placing a symbolic link to the source, adding a .pth file that points to your /satchmo/apps location or modifying your PYTHONPATH environment variable.

    Once the above step is completed, you should be able to import both django and satchmo:
"

echo "^C to break! here!@"

echo "    $ python
    Python 2.5.2 (r252:60911, Mar 12 2008, 13:39:09)
    [GCC 4.2.3 (Ubuntu 4.2.3-2ubuntu4)] on linux2
    Type \"help\", \"copyright\", \"credits\" or \"license\" for more information.
    >>> import django
    >>> import satchmo_store
    >>> satchmo_store.get_version()
"

#    '0.9-pre hg-YYYY:ZZZZZZZZZZ'



# install hg
cd ~
easy_install mercurial

mkdir ~/webapps
mkdir ~/webapps/myshop

# go to your app directory and set some variables and aliases to 
# make the intallation a bit easier
cd ~/webapps/myshop
export APPBIN=`pwd`/bin
export APPLIB=`pwd`/lib/python2.5
export PYTHONPATH=$APPLIB:$PYTHONPATH
alias easy_install="easy_install-2.5 -s $APPBIN -d $APPLIB"

# fetch dependencies
mkdir src
svn checkout http://django-app-plugins.googlecode.com/svn/trunk/ src/django-app-plugins-read-only
hg clone https://sorl-thumbnail.googlecode.com/hg/ src/sorl-thumbnail
hg clone http://bitbucket.org/bkroeze/django-signals-ahoy/ src/django-signals-ahoy
hg clone http://bitbucket.org/chris1610/satchmo/ src/satchmo

# install dependencies
easy_install pycrypto
easy_install http://code.enthought.com/enstaller/eggs/rhel/3/Reportlab-2.1.0001-py2.5.egg
easy_install http://www.satchmoproject.com/snapshots/trml2pdf-1.2.tar.gz
easy_install django-registration
easy_install PyYAML
easy_install http://bitbucket.org/bkroeze/django-threaded-multihost/downloads/django_threaded_multihost-1.3_2-py2.5.egg
easy_install src/django-app-plugins-read-only
easy_install src/sorl-thumbnail
easy_install src/django-signals-ahoy
easy_install src/satchmo

# copy satchmo local settings
cp ~/src/django/satchmo/satchmo/projects/base/local_settings.py satchmo_project/

cd ~/src/django/django-threaded-multihost/
sudo python setup.py install
cd /home/vhuang/webapps/myshop/src/satchmo/satchmo/projects/simple
python manage.py syncdb
python manage.py runserver

