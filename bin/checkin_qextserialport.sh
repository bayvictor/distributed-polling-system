echo "!!!! warning: this script when running as user www-data, every error resolved.!!!!"
#svn import /projects/myrailsproject file:///svnrepos/myrailsproject
echo "below line will checkin qextserialport source-code...."
echo "^C to break...anykey to checkin ..."
read readline
svn import /home/bsquare2/src/usb2com/qextserialport file:///svnrepos/qextserialport
echo "^C got to somewhere else to checkout from svn server  192.168.11.163..."
cd ~/src/qtest
svn co svn://192.168.11.163/svnrepos/qextserialport
echo "^C to break...anykey to checkout ..."
read readline
#192.168.11.163

#cd /svnrepos/
# below line looks like user n group is not apache
#sudo chown -R apache:apache *, sudo chmod -R 664 *

# on debian
cd /svnrepos/
sudo gpasswd -a svn-admin www-data
#sudo chgrp -R www-data svn/
#sudo chmod -R g=rwsx svn/
sudo chgrp -R www-data *
sudo chmod -R g=rwsx *

## vi /svnrepos/conf/passwd

echo "vi /svnrepos/conf/passwd

In that file add a line for your user:

# add users in the format : user = password tony = mypassword"

read readline

sudo vi /svnrepos/conf/passwd

cd ~
svnserve -d -r /svnrepos/
#Option expected
