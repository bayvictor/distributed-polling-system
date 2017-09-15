echo "run at root, as root!"
echo "^C to break, anykey to continue....";read readline

cd /

rm batch_gedit_fstabs.sh
rm ~/bin/batch_gedit_fstabs.sh
sudo blkid | cut -d":" -f1|cut -d"/" -f3|sed 's/^/gedit \//g'|sed -e 's|$|/etc/fstab \& |g' > test00.txt

sudo blkid |sed 's/\"//g'|sed 's/TYPE=/ \/ /g;s/$/   errors=remount-ro 0       1/g;s/^/#/g;s/^/echo \"/g;s/$/\">>/g' >> test01.txt

blkid | cut -d":" -f1|cut -d"/" -f3|sed 's/^/\//g'|sed -e 's|$|/etc/fstab \; |g' > echo_tail01.txt

paste test01.txt echo_tail01.txt  test00.txt > batch_gedit_fstabs.sh


chmod +x *.sh

gedit batch_gedit_fstabs.sh

echo "^C to break, anykey to continue running ~/bin/batch_gedit_fstabs.sh"

sudo ./batch_gedit_fstabs.sh



