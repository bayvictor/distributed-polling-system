sudo add-apt-repository  -y --force-yes  ppa:videolan/stable-daily
sudo add-apt-repository  -y --force-yes  ppa:otto-kesselgulasch/gimp
sudo add-apt-repository  -y --force-yes  ppa:gnome3-team/gnome3
sudo add-apt-repository  -y --force-yes  ppa:webupd8team/java
sudo add-apt-repository  -y --force-yes  ppa:webupd8team/y-ppa-manager
sudo add-apt-repository  -y --force-yes  ppa:transmissionbt/ppa
echo 'deb http://download.videolan.org/pub/debian/stable/ /' | sudo tee -a /etc/apt/sources.list.d/libdvdcss.list &&
echo 'deb-src http://download.videolan.org/pub/debian/stable/ /' | sudo tee -a /etc/apt/sources.list.d/libdvdcss.list &&
wget -O - http://download.videolan.org/pub/debian/videolan-apt.asc|sudo apt-key add -

sudo apt-get update  -y --force-yes 
sudo apt-get dist-upgrade -y --force-yes 
sudo apt-get upgrade -y --force-yes 
sudo apt-get install -y --force-yes  synaptic vlc gimp gimp-data gimp-plugin-registry gimp-data-extras y-ppa-manager bleachbit openjdk-7-jre oracle-java8-installer flashplugin-installer unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller libxine1-ffmpeg mencoder flac faac faad sox ffmpeg2theora libmpeg2-4 uudeview libmpeg3-1 mpeg3-utils mpegdemux liba52-dev mpeg2dec vorbis-tools id3v2 mpg321 mpg123 libflac++6 totem-mozilla icedax lame libmad0 libjpeg-progs libdvdcss2 libdvdread4 libdvdnav4 libswscale-extra-2 ubuntu-restricted-extras ubuntu-wallpapers*

if [[ $(getconf LONG_BIT) = "64" ]]
then
	echo "64bit Detected" &&
	echo "Installing Google Chrome" &&
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb &&
	sudo dpkg -i google-chrome-stable_current_amd64.deb &&
	rm -f google-chrome-stable_current_amd64.deb
else
	echo "32bit Detected" &&
	echo "Installing Google Chrome" &&
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb &&
	sudo dpkg -i google-chrome-stable_current_i386.deb &&
	rm -f google-chrome-stable_current_i386.deb
fi
echo "Cleaning Up" &&
sudo apt-get -f -y --force-yes  install &&
sudo apt-get autoremove  -y --force-yes  &&
sudo apt-get  -y --force-yes  autoclean &&
sudo apt-get  -y --force-yes  clean

