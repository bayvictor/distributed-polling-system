sudo apt-get install -y samba smbfs
sudo gedit /etc/samba/smb.conf
## add below 2 lines for above file
#security = user
#username map = /etc/samba/smbusers
sudo gedit /etc/samba/smbusers

sudo /etc/init.d/samba stop
sudo /etc/init.d/samba start
