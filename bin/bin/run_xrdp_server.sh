echo "

Hi all, I am a newbie of Linux. But after fighting one day, I manage to connect my xp sp3 to ubuntu 12.10 with xrdp installed.. Here is my steps. Hope this help others

1. install xrdp
"
sudo apt-get install xrdp

echo "2. install fallback
"
sudo apt-get install gnome-session-fallback

echo "3. logout and login again by gnome theme. You can choose theme before log in..

4. open terminal by ctrl alt t , then input"

echo "gnome-session --session=gnome" > ~/.xsession
# alternative: 
echo "gnome-session --session=ubuntu-2d" > ~/.xsession


echo "5. sudo gedit /etc/xrdp/startwm.sh
. /etc/X11/Xsession
to
. /home/$USER/.xsession
"
cat /etc/xrdp/startwm.sh|sed 's|/etc/X11/Xsession|/home/$USER/.xsession|g' > /tmp/test.txt
sudo cp /tmp/test.txt  /etc/xrdp/startwm.sh

echo "^c to break, anykey to \"gedit /etc/xrdp/startwm.sh\"..."; read readline

sudo gedit /etc/xrdp/startwm.sh

echo "^c to break, anykey to restart xrdp ..."; read readline
 
echo "6. sudo /etc/init.d/xrdp restart

7. finished. Enjoy!

Benny
"
sudo /etc/init.d/xrdp restart


