df -h|grep sda | cut -d"%" -f2|sed 's|$|/etc/default/grub|g;s/^/gedit /g;s/$/ \& /g'
echo "usage: $0 <drive_letter>"
echo "e.g.:  $0 sda "
echo "^c to break, anykey to continue...";read readline;  #"

df -h|grep "$1" | cut -d"%" -f2|sed 's|$|/etc/default/grub|g;s/^/gedit /g;s/$/ \& /g' | grep "$1" > ./bat_grub_edit.sh


chmod +x *.sh
./bat_grub_edit.sh


