#add below 2 lines into 
#deb http://ppa.launchpad.net/michael-gruz/canon/ubuntu YOUR_UBUNTU_VERSION_HERE main 
#deb-src http://ppa.launchpad.net/michael-gruz/canon/ubuntu YOUR_UBUNTU_VERSION_HERE main 



sudo dpkg -i --force-architecture cnijfilter-common_3.10-1_i386.deb
sudo dpkg -i --force-architecture cnijfilter-mx330series_3.10-1_i386.deb

sudo add-apt-repository ppa:michael-gruz/canon -y 
sudo apt-get update -y

sudo apt-get install cnijfilter-common -y --force-yes 
sudo apt-get install cnijfilter-mx330series -y  --force-yes 

sudo apt-get install cnijfilter-mx330series -y --force-yes

