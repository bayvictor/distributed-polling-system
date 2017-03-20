sudo wget -q "http://deb. playonlinux.com /public.gpg" -O- | sudo apt-key add -  
echo "above line:Add playonlinux repository and install it
"
sudo wget http://deb.playonlinux.com/ playonlinux_precise.list -O /etc/apt/sources.list.d/playonlinux.list
sudo apt-get update
sudo apt-get install playonlinux
echo "In case you get an error, do this else skip to next
"
sudo apt-get install curl p7zip-full p7zip-rar
echo "Now run it
"
sudo playonlinux

