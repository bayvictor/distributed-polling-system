#You need the Ubuntu Alternate CD (not the Desktop CD).

#Then type 
sudo apt-cdrom add
sudo apt-get update
sudo apt-get install -y ubuntu-desktop
sudo dpkg-reconfigure xserver-xorg
sudo /etc/init.d/gdm start
#shinigami16

