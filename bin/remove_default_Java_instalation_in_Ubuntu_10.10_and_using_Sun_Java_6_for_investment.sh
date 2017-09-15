echo "Default java instalation Ubuntu in Amazon EC2 AMI is using java-1.6.0-openjdk. When you using SOLR, Tomcat 6 and Glassfish, sometimes you meet condition that need FULL of Sun java 6 JDK + JRE. So, i think, it's will be good point if we remove default Java instalation in Ubuntu 10.10 and using Sun Java 6 for investment. So, here are steps for removing it"
read read_line 

echo "#1. Update Ubuntu Repository" 
read read_line
sudo add-apt-repository "deb http://archive.canonical.com/ maverick partner"
sudo apt-get update
sudo apt-get remove openjdk-6-jre-headless
sudo apt-get install -y sun-java6-jdk sun-java6-jre
sudo apt-get autoremove



read read_line
echo "2. Set what kind of Java we used in Ubuntu Linux "
sudo update-alternatives --config java


read read_line





