#sudo apt-get install -y sun-java-jdk sun-java-jre

#sudo apt-get install -y --force-yes  openjdk-6-jdk default-jdk
#sudo apt-get install -y --force-yes openjdk-7-jdk default-jdk
#sudo apt-get install -y --force-yes openjdk-8-jdk default-jdk
sudo apt-get autoremove 
#sudo apt-get remove icetea

echo "in ubuntu 14.10, install oracle_java8 instead of openjdk ... buggy"

echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
apt-get update
apt-get install oracle-java8-installer

sudo ./install_oracle_java8.sh

 sudo apt-get install -y --force-yes linux-tools
 sudo apt-get install -y --force-yes linux-cloud-tools
sudo apt-get install -y --force-yes ant

echo "will install maven ..."
sudo apt-get install -y --force-yes libclojure-maven-plugin-java # - Clojure plugin for Maven
sudo apt-get install -y --force-yes libmojomojo-perl #- wiki- and blog-inspired content management system

