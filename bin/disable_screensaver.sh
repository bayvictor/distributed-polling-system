echo "Home / Tips and Tricks / Ubuntu / How to Disable Screensaver/Lock Screen/Sleep Mode in Ubuntu?
How to Disable Screensaver/Lock Screen/Sleep Mode in Ubuntu?
 Echo  Tips and Tricks, Ubuntu
This tutorial will teach you how to temporarily prevent your computer from activating the screensaver and/or the "sleep" power saving feature of Ubuntu. 

Open your terminal and type the following commands:

Adding the caffeine repository:
"
 sudo add-apt-repository ppa:caffeine-developers/ppa
echo "Updating your Ubuntu System:
"
 sudo apt-get -y update
echo "Install Caffeine:
"
 sudo apt-get install -y caffeine python-glade2
caffeine

