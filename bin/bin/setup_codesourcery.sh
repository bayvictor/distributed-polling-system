# First create a work dir
mkdir -p ~/stm32/CodeSourcery/
cd ~/stm32/CodeSourcery/

# Get the installer and the manual
wget http://www.codesourcery.com/sgpp/lite/arm/portal/package6495/public/arm-none-eabi/arm-2010q1-188-arm-none-eabi.bin
wget http://www.codesourcery.com/sgpp/lite/arm/portal/doc7615/getting-started.pdf

# Open the installation manual, so you can read it if you need to...
evince getting-started.pdf &

# CodeSourcery has a problem with dash, so make sure you don't use it. 
sudo dpkg-reconfigure -plow dash
#And then answer No

# Now bash is the default /bin/sh and not dash!
ls -lh /bin/sh

# Create the install dir.
sudo mkdir -p  /usr/local/CodeSourcery
sudo chown $USER.users  /usr/local/CodeSourcery

# And create a add to path script
echo "export PATH=/usr/local/CodeSourcery/bin:\$PATH" > ~/stm32/bin/CodeSourcery_setup.sh 

#Then we start the installer.

/bin/sh arm-2010q1-188-arm-none-eabi.bin 


#    * Minimal installation
#    * Install dir: /usr/local/CodeSourcery
#    * No add to path! (if you don't wan't this off course)
#    * No linkdir! 

echo "Then when you need this compiler you run this script.

source ~/stm32/bin/CodeSourcery_setup.sh 
"
source ~/stm32/bin/CodeSourcery_setup.sh 

