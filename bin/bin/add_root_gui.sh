sudo passwd root
echo "Enter new UNIX password:

Now you have root password. Now activate the root account:
i"
sudo usermod -U root
echo "
Then you should allow lightdm, gdm or kdm to allow logging in as root.

To enable this:
In GDM

Edit /etc/gdm/custom.conf file and include AllowRoot=true.
"

echo "^C to break, anykey to continue...";read readline
sudo mkdir /etc/gdm
sudo vi /etc/gdm/custom.conf

