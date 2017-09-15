 sudo mkdir  /etc/zookeeper/
 sudo mkdir  /etc/zookeeper/conf/

 sudo apt-get install -y --force-yes python-zookeeper #- Python bindings for zookeeper
 sudo apt-get install -y --force-yes zookeeper #- High-performance coordination service for distributed applicat
 sudo apt-get install -y --force-yes zookeeper-bin #- Command line utilities for zookeeper

# vi /etc/zookeeper/conf/myid
sudo echo "
server.11=sd1:2888:3888
server.12=sd2:2888:3888
server.13=sd3:2888:3888
server.14=sd4:2888:3888
server.15=sd5:2888:3888


">> /etc/zookeeper/conf/myid 

cat /etc/zookeeper/conf/myid




 sudo service zookeeper restart



