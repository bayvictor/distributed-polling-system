echo "10 December 2011
How to Install Canon PIXMA MP, Canon MX, Pixma MG, and Pixma iP Series Drivers on Ubuntu 11.10/11.04

In this guide we will see how to install drivers for some various Canon printers as described below. The drivers will be compatible with Ubuntu 11.10 Oneiric Ocelot and Ubuntu 11.04 Natty Narhwal, also older versions of Ubuntu are also included.

To make this possible we need to use the PPA found here which contains most drivers for different Canon printer models. So, to install this PPA under Ubuntu 11.10/11.04, open the terminal and run these two commands:
"
sudo add-apt-repository ppa:michael-gruz/canon
sudo apt-get update
echo "- Canon MX330:
"
sudo apt-get install cnijfilter-mx330series

echo "Now remove any old unused printer driver you have installed and disconnect your printer from your computer or turn it off. Then, install the appropriate driver from one of these commands:

1. Canon Pixma iP Series

- Canon iP100:

sudo apt-get install cnijfilter-ip100series

- Canon iP1800:

sudo apt-get install cnijfilter-ip1800series

- Canon iP1000:

sudo apt-get install cnijfilter-pixmaip1000series

- Canon iP1500:

sudo apt-get install cnijfilter-pixmaip1500series

- Canon iP1900:

sudo apt-get install cnijfilter-ip1900series

- Canon iP2200:

sudo apt-get install cnijfilter-ip2200series

- Canon iP2500:

sudo apt-get install cnijfilter-ip2500series

- Canon iP2600:

sudo apt-get install cnijfilter-ip2600series

- Canon iP2700:

sudo apt-get install cnijfilter-ip2700series

- Canon iP3300:

sudo apt-get install cnijfilter-ip3300series

- Canon iP3500:

sudo apt-get install cnijfilter-ip3500series

- Canon iP3600:

sudo apt-get install cnijfilter-ip3600series

- Canon iP4200:

sudo apt-get install cnijfilter-ip4200series

- Canon iP4500:

sudo apt-get install cnijfilter-ip4500series

- Canon iP4700:

sudo apt-get install cnijfilter-ip4700series

- Canon iP4800:

sudo apt-get install cnijfilter-ip4800series

- Canon iP5200:

sudo apt-get install cnijfilter-ip5200series

- Canon iP6600:

sudo apt-get install cnijfilter-ip6600series

- Canon iP7500:

sudo apt-get install cnijfilter-ip7500series



2. Canon Pixma MG Series

Canon MG5100:

sudo apt-get install cnijfilter-mg5100series

- Canon MG5200:

sudo apt-get install cnijfilter-mg5200series

- Canon MG6100:

sudo apt-get install cnijfilter-mg6100series

- Canon MG8100:

sudo apt-get install cnijfilter-mg8100series



3. Canon PIXMA MP Series

- Canon MP140:

sudo apt-get install cnijfilter-mp140series

- Canon MP160:

sudo apt-get install cnijfilter-mp160series

- Canon MP190:

sudo apt-get install cnijfilter-mp190series

- Canon MP210:

sudo apt-get install cnijfilter-mp210series

- Canon MP240:

sudo apt-get install cnijfilter-mp240series

- Canon MP490:

sudo apt-get install cnijfilter-mp490series

- Canon MP500:

sudo apt-get install cnijfilter-mp500series

- Canon MP510:

sudo apt-get install cnijfilter-mp510series

- Canon MP520:

sudo apt-get install cnijfilter-mp520series

- Canon MP540:

sudo apt-get install cnijfilter-mp540series

- Canon MP550:

sudo apt-get install cnijfilter-mp550series

- Canon MP560:

sudo apt-get install cnijfilter-mp560series

- Canon MP600:

sudo apt-get install cnijfilter-mp600series

- Canon MP610:

sudo apt-get install cnijfilter-mp610series

- Canon MP630:

sudo apt-get install cnijfilter-mp630series

- Canon MP640:

sudo apt-get install cnijfilter-mp640series



4. Canon MX Series

- Canon MX320:

sudo apt-get install cnijfilter-mx320series

- Canon MX330:

sudo apt-get install cnijfilter-mx330series

- Canon MX350:

sudo apt-get install cnijfilter-mx350series

- Canon MX360:

sudo apt-get install cnijfilter-mx360series

- Canon MX410:

sudo apt-get install cnijfilter-mx410series

- Canon MX420:

sudo apt-get install cnijfilter-mx420series

- Canon MX860:

sudo apt-get install cnijfilter-mx860series

- Canon MX870:

sudo apt-get install cnijfilter-mx870series

- Canon MX880:

sudo apt-get install cnijfilter-mx880series

Once your printer driver is well installed, connect your printer to your computer and turn it on. The driver will be detected automatically. You can also add it manually as described here.

Good luck!

Related Posts


How To Install CANON Pixus Series P...

How To Install Canon Pixma iP1800/ ...

Install Drivers For More Than 2000 ...

  
  
Subscribe Now !
  
Follow us on:
        
 
 
Popular Posts
 
To Do List After A New Installation Of Ubuntu 12.10 (Quantal Quetzal)
 
11 Tips To Speed Up Computers Running Ubuntu 12.10/12.04/Linux Mint 13 (Maya)
 
Install Linux Kernel 3.7.7 On Ubuntu/Linux Mint
 
Install/Upgrade to Linux Kernel 3.7.3 in Ubuntu/Linux Mint





 

Tags
Graphics (60) Browsers (18) Tweaks (17) Conky (14) News (14) Debian (13) Office (13) Backup (12) Burning (10) Education (6) Enterprise Software (2) Monitoring (2) Miscellaneous (1)

Privacy Policy - About US - Contact US - All Rights Reserved | UpUbuntu
"
