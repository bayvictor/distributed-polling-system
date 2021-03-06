sudo apt-get update -y 
sudo apt-get install -y samba samba-common samba-common-bin smbclient system-config-samba nautilus-data

sudo apt-get install -y nautilus-share
sudo useradd -s /sbin/nologin vhuang
sudo smbpasswd -a vhuang
sudo mkdir /media/vhuang
sudo mkdir /media/vhuang/share
sudo chmod -Rf 777 /media/vhuang/share


sudo useradd -s /sbin/nologin root
sudo smbpasswd -a root
sudo mkdir /media/root
sudo mkdir /media/root/share
sudo chmod -Rf 777 /media/root/share

sudo useradd -s /sbin/nologin daniel
sudo smbpasswd -a daniel
sudo mkdir /media/daniel
sudo mkdir /media/daniel/share
sudo chmod -Rf 777 /media/daniel/share

echo "doing ...
sudo mkdir /media/<user_name>/share
sudo chmod -Rf 777 /media/<user_name>/share
for all users added !"

cd /media

users=`subdirlist.sh |tr '\n' ','`
paths=`echo $users | tr ',' '\n'|sed 's|^|path=/media/|g;s|$|/share|g'`
sudo echo "[Share]
" >> /etc/samba/smb.conf
sudo  echo $paths | tr ' ' '\n'  >> /etc/samba/smb.conf

sudo echo "available = yes
valid users = "$users" 
read only = no
browseable = yes
public = yes
writable = yes
" >> /etc/samba/smb.conf



