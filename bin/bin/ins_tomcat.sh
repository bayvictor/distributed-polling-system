dpkg --get-selections | grep sun-java
sudo apt-get install -y sun-java6-jdk
mkdir /sda354T

cd /sda354/bin
wget http://apache.hoxt.com/tomcat/tomcat-6/v6.0.26/bin/apache-tomcat-6.0.26.tar.gz
tar -zxvf apache-tomcat*.tar.gz
sudo mv apache-tomcat-6.0.26 /usr/local/tomcat
echo "export JAVA_HOME=/usr/lib/jvm/java-6-sun">>~/.bashrc



    sudo chmod 755 /etc/init.d/tomcat

#The last step is actually linking this script to the startup folders with a symbolic link. Execute these two commands and we should be on our way.

    sudo ln -s /etc/init.d/tomcat /etc/rc1.d/K99tomcat
    sudo ln -s /etc/init.d/tomcat /etc/rc2.d/S99tomcat





