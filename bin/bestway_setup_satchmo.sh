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
cp src/satchmo/satchmo/projects/base/local_settings.py myproject/
