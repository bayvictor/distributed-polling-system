echo "Step 1. Execute the following command in terminal.

sudo gedit /usr/share/lightdm/lightdm.conf.d/50-unity-greeter.conf


echo  Step 2: Add the following statement.


greeter-show-manual-login=true
Step 3: Save and close gedit.

Now, restart your Ubuntu machine. You will see a ‘Login’ as one of the option in login prompt. I believe you guys know the rest ;-)
"

sudo echo "greeter-show-manual-login=true
">> /usr/share/lightdm/lightdm.conf.d/50-unity-greeter.conf
sudo echo "greeter-show-manual-login=true" >> /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf 
sudo su -s
passwd root

    

echo "root@vhuang-topwire:/home/vhuang/bin# cat  /usr/share/lightdm/50-ubuntu.conf 
allow-guest=false #-----------------------------------------for disabling GUEST SESSION
greeter-show-manual-login=true #--------------------------root GUI and other login
#greeter-hide-users=true ---------------------------hiding all the users from login screen
"



echo  "^C to break, any key to reboot then login as ROOT"
sudo reboot

