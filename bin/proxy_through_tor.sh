echo "tor:free implementation of anonymity network which protects your privacy over the internet. Tor enable this by providing virtual tunnel to internet application through SOCKS interface. This post will show you how to setup and use Tor to connect to internet anonymously."

echo "1. First of all you need to install tor and privoxy package"

#sudo  apt-get install -y tor

sudo  apt-get install -y privoxy

echo "#   2. Then you need to edit privoxy config file for some quick setup,
"
sudo  gksudo gedit /etc/privoxy/config

echo "#   3. You need to comment \"logfile logfile\" line and add this line at the end of the file

      forward-socks4a/localhost:9050 .
"
read read_line
echo "#   4. Save the file and restart privoxy service."

      sudo /etc/init.d/privoxy restart
read read_line
echo "#   5. You should be able to connect through Tor by using application which supports SOCK 4a/SOCK 5 interface with port 9050.

#Here's a screenshot of Mozilla Firefox and Gaim setup to use Tor
#firefox.png
"
read read_line
echo "#gaim.png

#You can access those screen through Edit->Preference->Advanced->Network->Settings in Mozilla Firefox and Account->Advance Tab in Gaim/Pidgin. Other application which supports SOCK 5 can be configured similarly to connect through Tor (including Xchat irc client and other internet browser)
"
read read_line
echo "#Other Operating System
#Tor (and Privoxy) is also supported on other operating system including Windows, Mac OS and other Unix-like operating system. Please refer to Tor Download page for instructions to use tor on those system
"
read read_line
echo "
#D
#A
#Tags: tor, ubuntu, proxy, feisty fawn, debian
"