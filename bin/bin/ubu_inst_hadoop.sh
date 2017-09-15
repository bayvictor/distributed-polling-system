echo "we started with the vanilla alestic Ubuntu 9.04 Jaunty 64Bit Server AMI: ami-5b46a732 and instantiated 6 High CPU Large Instances. You really want as much memory and cores as you can get. You can do the following by hand or combine it with the shell scripting described below in the section Installing Hadoop and HBase."
sudo apt-get update
echo "we setup 64java with sun6-64bit shifting from openjdk \"sudo update-alternatives --config java\""
sudo update-alternatives --config java

sudo apt-get upgrade

echo "Then added via apt-get install:"

sudo apt-get install -y sun-java6-jdk

read read_line
echo "Downloading Hadoop and HBase

You can use the production Hadoop 0.20.0 release. You can find them at the mirrors at http://www.apache.org/dyn/closer.cgi/hadoop/core/. The examples show from one mirror:

wget http://mirror.cloudera.com/apache/hadoop/core/hadoop-0.20.0/hadoop-0.20.0.tar.gz
"


read read_line
echo "You can download the HBase 0.20.0 Release Candidate 3 in a prebuilt form from http://people.apache.org/~stack/hbase-0.20.0-candidate-3/ (You can get the source out of Version Control:http://hadoop.apache.org/hbase/version_control.html but  you'll have to figure out how to build it.)
"
mkdir ~/src
mkdir ~/src/_hadoop_hbase
cd ~/src/_hadoop_hbase


wget http://mirror.cloudera.com/apache/hadoop/core/stable/hadoop-0.20.2.tar.gz

wget http://people.apache.org/~stack/hbase-0.20.4-candidate-2/hbase-0.20.4.tar.gz


tar -zxvf hadoop-0.20.2.tar.gz
cd hadoop-0.20.2
./configure
make
sudo make install
cd .. 
tar -zxvf hbase-0.20.4.tar.gz 
cd hbase-0.20.4
./configure
make
sudo make install
cd ..
read read_line
echo "Installing Hadoop and HBase

Assuming that you are running in your home directory on the master server and that the target for the versioned packages is in /mnt/pkgs and that there will be a link in /mnt for the path to the home for hadoop and hbase:

You can do a some simple scripting to do the following on all the nodes at once"


echo 'Create a file named servers with the list of the fully qualified domain names of all your servers including “localhost” for the master and call the file “servers”.

Make sure you can ssh to all the servers from the master. Ideally you are using ssh keys. On master:
'

read read_line

ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys

echo 'On each of your region servers make sure that the id_dsa.pub is also in their authorized_keys (don’t delete any other keys you have in the authorized keys!)

Now with a bit of shell command line scripting you can install on all your servers at once:
'


read read_line

for host in `cat servers`
 do
 echo $host
 ssh $host 'apt-get update; apt-get upgrade; apt-get install -y sun-java6-jdk'
 scp ~/hadoop-0.20.0.tar.gz ~/hbase-0.20.0.tar.gz $host:
 ssh $host 'mkdir -p /mnt/pkgs; cd /mnt/pkgs; tar xzf ~/hadoop-0.20.0.tar.gz; tar xzf ~/hbase-0.20.0.tar.gz; ln -s /mnt/pkgs/hadoop-0.20.0 /mnt/hadoop; ln -s /mnt/pkgs/hbase-0.20.0 /mnt/hbase'
done

read read_line
echo 'Use Amazon Private DNS Names in Config files

So far I have found that its best to use the Amazon Private DNS names in the hadoop and hbase config files. It looks like HBase uses the system hostname to determine various things at runtime. Thie is always the Private DNS name. It also means that its difficult to use the Web GUI interfaces to HBase from outside of the Amazon Cloud. I set up a “desktop” version of Ubuntu that is running in the Amazon Cloud that I VNC (or NX) into and use its browser to view the Web Interface.

In any case, Amazon instances normally have limited TCP/UDP access to the outside world due to the default security group settings. You would have to add the various ports used by HBase and Hadoop to the security group to allow outside access.

If you do use the Amazon Public DNS names in the config files, there will be startup errors like the following for each instance that is assigned to the zookeeper quorum (there may be other errors as well, but these are the most obvious):

ec2-75-101-104-121.compute-1.amazonaws.com: java.io.IOException: Could not find my address: domU-12-31-39-06-9D-51.compute-1.internal in list of ZooKeeper quorum servers
ec2-75-101-104-121.compute-1.amazonaws.com:     at org.apache.hadoop.hbase.zookeeper.HQuorumPeer.writeMyID(HQuorumPeer.java:128)
ec2-75-101-104-121.compute-1.amazonaws.com:     at org.apache.hadoop.hbase.zookeeper.HQuorumPeer.main(HQuorumPeer.java:67)
'
read read_line
echo 'Configuring Hadoop

Now you have to configure the hadoop on master in /mnt/hadoop/conf:
hadoop-env.sh:

The minimal things to change are:

Set your JAVA_HOME to where the java package is installed. On Ubuntu:
'

read read_line

export JAVA_HOME=/usr/lib/jvm/java-6-sun

echo 'Add the hbase path to the HADOOP_CLASSPATH:
'

read read_line
export HADOOP_CLASSPATH=/mnt/hbase/hbase-0.20.0.jar:/mnt/hbase/hbase-0.20.0-test.jar:/conf



read read_line
