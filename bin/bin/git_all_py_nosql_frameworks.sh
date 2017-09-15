mkdir ~/src
mkdir ~/src/3d
mkdir ~/src/3d/py_nosql_frameworks
cd  ~/src/3d/py_nosql_frameworks

git clone https://github.com/pycassa/pycassa.git
git clone https://github.com/basho/riak-python-client.git
git clone https://github.com/andymccurdy/redis-py.git
git clone git://github.com/mongodb/mongo-python-driver.git pymongo
cd pymongo/
python setup.py install

echo "install couchdb with it's source code..."
sudo apt-get install couchdb -y



echo "will do:
cat ~/bin/couch+django*.sh

"
echo "^C to break, anykey to continue...";read readline
cat ~/bin/couch+django*.sh


curl -O http://python-distribute.org/distribute_setup.py
sudo python distribute_setup.py
easy_install pip

echo"o install or upgrade to the latest released version of couchdbkit:

    $ "

echo "^C to break, anykey to continue...";read readline

sudo apt-get install -y g++
sudo apt-get install -y erlang-dev erlang-manpages erlang-base-hipe erlang-eunit erlang-nox erlang-xmerl erlang-inets
### other packages that are not required but may be useful
# - require GUI packages / X
# sudo apt-get install -y erlang-observer erlang-appmon erlang-debugger erlang-et
# - useful erlang tools to develop with
# sudo apt-get install -y erlang-dialyzer erlang-percept erlang-typer erlang-edoc erlang-os-mon erlang-runtime-tools erlang-inviso erlang-tools

### couchdb developer dependencies
sudo apt-get install -y libmozjs185-dev libicu-dev libcurl4-gnutls-dev libtool
### unpack source
cd /tmp && tar xvzf apache-couchdb-1.2.1.tar.gz
cd apache-couchdb-*
./configure && make
### install
sudo make install

### remove leftovers from ubuntu packages
sudo rm /etc/logrotate.d/couchdb /etc/init.d/couchdb

### install logrotate and initd scripts
sudo ln -s /usr/local/etc/logrotate.d/couchdb /etc/logrotate.d/couchdb
sudo ln -s /usr/local/etc/init.d/couchdb  /etc/init.d
sudo update-rc.d couchdb defaults



pip install couchdbkit

echo "end of installing chouchDB, couchdbkit!....."
echo "^C to break, anykey to continue...";read readline

chown vhuang * -R

