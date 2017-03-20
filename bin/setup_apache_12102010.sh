
sudo apt-get install -y maven2 
sudo apt-get install -y apache2-dev python-dev

sudo apt-get install -y libapache2-mod-wsgi

sudo chown  vhuang /usr/local/src -R
cd /usr/local/src
mkdir tomcat6
cd tomcat6

wget http://apache.hoxt.com/tomcat/tomcat-6/v6.0.26/bin/apache-tomcat-6.0.26.tar.gz
tar -zxvf apache-tomcat*.tar.gz
sudo mv apache-tomcat-6.0.26 /usr/local/tomcat
s

echo "^C to break, anykey to proceed..."
read read_line

sudo cp /usr/lib/apache2/modules/mod_wsgi.so /etc/apache2/
sudo cp ~/src/social_project/httpd.conf /etc/apache2/
sudo apt-get install -y apache2 php5-mysql libapache2-mod-php5 mysql-server
cd /usr/local/apache2/bin
sudo ./apachectl start


tail -f /var/logs/apache2/access.log
 sudo rm /var/log/apache2/error.log
 sudo rm /var/log/apache2/access.log
sudo /etc/init.d/apache2 restart
tail -f /var/log/apache2/error.log
sudo /etc/init.d/apache2 start
sudo /etc/init.d/apache2 stop
cp ${TLDIR}/upnp-browser-1.0-alpha6.apk '/usr/local/apache2/htdocs/upnp-browser-1.0-alpha6.apk' 
udo apt-get install -y libapache2-mod-wsgi
sudo apt-get install -y apache2-threaded-dev #2.2.11-2ubuntu2.3, resolve apxs
## resolve_segm_fault_in_apache_log.sh
sudo cp /etc/apache2/httpd.conf /etc/apache2/httpd.conf.20100519
sudo chown vhuang /etc/apache2/httpd.conf
cp ~/src/pinax_scripts/httpd.conf /etc/apache2/httpd.conf
~/src/apache_restart.sh
    -Declipse.workspaceCodeStyleURL=http://svn.apache.org/repos/asf/maven/plugins/trunk/maven-eclipse-plugin/src/optional/eclipse-config/maven-styles.xml 
#      http://www.apache.org/licenses/LICENSE-2.0
You can use the production Hadoop 0.20.0 release. You can find them at the mirrors at http://www.apache.org/dyn/closer.cgi/hadoop/core/. The examples show from one mirror:
wget http://mirror.cloudera.com/apache/hadoop/core/hadoop-0.20.0/hadoop-0.20.0.tar.gz
echo "You can download the HBase 0.20.0 Release Candidate 3 in a prebuilt form from http://people.apache.org/~stack/hbase-0.20.0-candidate-3/ (You can get the source out of Version Control:http://hadoop.apache.org/hbase/version_control.html but  you'll have to figure out how to build it.)"
wget http://mirror.cloudera.com/apache/hadoop/core/stable/hadoop-0.20.2.tar.gz
wget http://people.apache.org/~stack/hbase-0.20.4-candidate-2/hbase-0.20.4.tar.gz
ec2-75-101-104-121.compute-1.amazonaws.com:     at org.apache.hadoop.hbase.zookeeper.HQuorumPeer.writeMyID(HQuorumPeer.java:128)
ec2-75-101-104-121.compute-1.amazonaws.com:     at org.apache.hadoop.hbase.zookeeper.HQuorumPeer.main(HQuorumPeer.java:67)
