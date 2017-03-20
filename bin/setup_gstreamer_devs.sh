#apt-cache search gstreamer | grep dev | cut -d"-" -f1 | sed 's/^/sudo apt-get install -y /g' > ~/bin/setup_gstreamer_devs.sh

sudo apt-get install -y libgnome
sudo apt-get install -y libgstreamer
sudo apt-get install -y libgstreamer0.10
sudo apt-get install -y libnice
sudo apt-get install -y python
sudo apt-get install -y gnome
sudo apt-get install -y libclutter
sudo apt-get install -y libghc6
sudo apt-get install -y libgstbuzztard
sudo apt-get install -y libgstreamermm
sudo apt-get install -y libgstrtspserver
sudo apt-get install -y parole
sudo apt-get install -y rygel




