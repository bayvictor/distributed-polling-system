echo " below first round running will miss sun-java6-jre etc, please 
run sudo apt-get -f to resovle the dependence issue!"
sudo apt-get install -y gdebi 
#msung-sdk-eclipse depends on sun-java6-jre










echo  "Default java instalation Ubuntu in Amazon EC2 AMI is using java-1.6.0-openjdk. When you using SOLR, Tomcat 6 and Glassfish, sometimes you meet condition that need FULL of Sun java 6 JDK + JRE. So, i think, it's will be good point if we remove default Java instalation in Ubuntu 10.10 and using Sun Java 6 for investment. So, here are steps for removing it"
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

sudo apt-get install -y openjre-6
sudo apt-get install -y devhelp
sudo apt-get install -y xcompmgr 


echo "^to break, "; read read_line
sudo dpkg -i ./simulator/samsung-sdk-simulator-kernel_1.0-14_i386.deb
sudo dpkg -i ./simulator/samsung-sdk-simulator_1.0-41_i386.deb
sudo dpkg -i ./simulator/samsung-sdk-telephony-emulator_1.0-8_i386.deb

sudo dpkg -i ./scratchbox/scratchbox-core-samsung-patch_0.1.23_i386.deb
echo "^to break, "; read read_line


sudo dpkg -i ./tools/resource/samsung-sdk-menu_1.0-11_i386.deb
#sudo apt-get install -y sun-java6-jre
sudo apt-get install -y openjdk-6-jre


sudo dpkg -i ./ide/samsung-sdk-eclipse_1.3.13_i386.deb
echo "^to break, "; read read_line

sudo dpkg -i ./gui_builder/samsung-sdk-gtk-gui-builder_1.0-45_i386.deb
sudo dpkg -i ./gui_builder/samsung-sdk-editje_1.0-29_i386.deb

sudo dpkg -i ./docs/samsung-sdk-api-document_1.0.0-20101103-pre1build2_i386.deb

echo "^to break, "; read read_line
