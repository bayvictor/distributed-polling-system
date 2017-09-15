#Install CVS files:
sudo apt-get install -y cvs

#Install the CVS server:
sudo apt-get install -y cvsd

echo "#When prompted in the cvsd installation process for Repository, type in -Y´/cvsrepo¡."

echo "Now that the cvsd installation in complete goto /var/lib/cvsd
or seeking for a change(or if there is a new version of cvs updated):"

read read_line
sudo cvsd-buildroot /var/lib/cvsd

echo "If the folder cvsrepo does not exist, then create it .."
sudo mkdir /var/lib/cvsd/cvsrepo
sudo cd /var/lib/cvsd/
sudo chown -R cvsd:cvsd  /var/lib/cvsd/cvsrepo
#sudo chown -R cvsd:cvsd cvsrepo

echo "and then initilize the repository"
sudo cvs -d /var/lib/cvsd/cvsrepo init

echo "create a user and password"

sudo cvsd-passwd /var/lib/cvsd/cvsrepo +vhuang #username

echo 'Change "SystemAuto=no"'
read read_line



sudo vi //var/lib/cvsd/cvsrepo/CVSROOT/config


echo "Test..."
read read_line

cvs -d :pserver:vhuang@localhost:/cvsrepo login


cvs -d :pserver:vhuang@localhost:/cvsrepo checkout .

echo "posted by Ripple @ 2:54 PM"
