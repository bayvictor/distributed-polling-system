sudo mkdir /opt/media
sudo chown $USER /opt/media -R

sudo apt-get install -y libgudev-1.0-dev
#libgudev
echo "^C to break, anykey to continue..."
read readline


sudo apt-get install -y gettext
echo "^C to break, anykey to continue..."
read readline

apt-get source intltool
cd intltool* 
armconf
echo "press any key to continue, ^C to quit"
read readline
cd ..
#apt-get source cheese
cd ~/src/cheese-2.32.0
armconf

