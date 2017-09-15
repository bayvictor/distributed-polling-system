echo "First of all, let's add the DataStax repository key.

$ "
curl -L http://debian.datastax.com/debian/repo_key | sudo apt-key add -

echo "Add DataStax Cassandra repository to a new apt source list.

$ "
echo "deb http://debian.datastax.com/community stable main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list

echo "Make apt-get read the metadata of Cassandra repository.

$ i"

sudo apt-get update
echo "
Now let's install Cassandra 2.2. This is the latest stable version of Cassandra at the time of writing. You can check Planet Cassandra Download Page for information on the latest stable relase of Apache Cassandra.

$ "
 sudo apt-get install -y --force-yes cassandra-tools #- distributed storage system for structured data
 sudo apt-get install -y --force-yes cassandra #- distributed storage system for structured data



 sudo apt-get install -y --force-yes python-cassandra #- Python driver for Apache Cassandra
 sudo apt-get install -y --force-yes python-pycassa #- Client library for Apache Cassandra
 sudo apt-get install -y --force-yes python3-cassandra #- Python driver for Apache Cassandra (Python 3)
echo "^C to break, anykey to continue...";read readline
sudo service cassandra status * could not access pidfile for Cassandra

echo "^C to break, anykey to continue...";read readline
sudo apt-get install dsc22=2.2.3-1 cassandra=2.2.3

echo "This is optional, we'll install Cassandra utilities.

$ "

echo "^C to break, anykey to continue...";read readline
sudo apt-get install cassandra-tools=2.2.3

echo "You can check the Cassandra service using the command below

$ i"
sudo service cassandra status * could not access pidfile for Cassandra

echo "The information above is actually false. The Cassandra process is running but it report that it could not access Cassandra pidfile. This is due to bug on the Cassandra init script. We'll fix this in the next section.

We can also check cluster status using nodetool command :

$ i"
nodetool status

echo "^C to break, anykey to continue...";read readline
echo "
Datacenter: datacenter1
Status=Up/Down |/ State=Normal/Leaving/Joining/Moving -- Address Load Tokens Owns Host ID Rack UN 127.0.0.1 179.29 KB 256 ? 7cd1bdc4-8bfa-49d9-a453-e0cf83bf956f rack1

Note: Non-system E$keyspaces don't have the same replication settings, effective ownership information is meaningless 

Leti\'s try connecting to Cassandra server using cqlsh. You can use the command below

$ cqlsh Connected to Test Cluster at 127.0.0.1:9042. [cqlsh 5.0.1 | Cassandra 2.2.3 | CQL spec 3.3.1 | Native protocol v4] Use HELP for help. cqlsh> quit

We will not do anything now, so just type quit on the cqlsh shell.

i"
 sudo apt-get install -y --force-yes python-cassandra #- Python driver for Apache Cassandra

