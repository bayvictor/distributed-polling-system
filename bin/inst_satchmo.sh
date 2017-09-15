    easy_install pycrypto
    easy_install http://www.satchmoproject.com/snapshots/trml2pdf-1.2.tar.gz
    easy_install PyYAML
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
        hg clone http://bitbucket.org/bkroeze/django-threaded-multihost/
        cd ${CUR_PATH}/django-threaded-multihost
        python setup.py install

echo "    Install django-app-plugins:

        Check out the satchmo-enhanced version:
"
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

        hg clone http://bitbucket.org/bkroeze/django-signals-ahoy/
        cd ${CUR_PATH}/django-signals-ahoy
        python setup.py install

echo "    Install livesettings:

        Check out from source:
"
        hg clone http://bitbucket.org/bkroeze/django-livesettings/
        cd ${CUR_PATH}/djang-livesettings
        python setup.py install

echo "    New in version 0.9.1.

    Install keyedcache:

        Check out from source:
"

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

        hg clone http://bitbucket.org/hynekcer/django-registration/
        cd ${CUR_PATH}/django-registration
        python setup.py install

echo "Installing Satchmo into your path

    Checkout the latest Satchmo release into /home/user/src:
"
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


