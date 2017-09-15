sudo blkid > id.txt
cat id.txt | sed 's/UUID=\"/@/g'|tr '@' '\n' |cut -d'"' -f1| grep -v ":" > mount_uuid_list.txt
cat id.txt | cut -d":" -f1 > mount_devices.txt
cat mount_devices.txt | cut -d'/' -f3 |sed 's/^/ \//g' > mount_mount_list.txt
cat  mount_mount_list.txt|sed 's/^/sudo mkdir /g'>mkdir_for_mount_points.sh
chmod +x *.sh
./mkdir_for_mount_points.sh 
cat mount_type_list.txt | sed 's/^/ -t  /g' > mount_type_list2.txt 
cat mount_uuid_list.txt | sed 's/^/sudo mount -U /g' > mount_uuid_list2.txt

paste  mount_uuid_list2.txt mount_type_list2.txt  mount_mount_list.txt > manual_mount_all_raid_disks.sh

chmod +x *.sh
gedit manual_mount_all_raid_disks.sh
echo "^c to break, anyother key to continue"
./manual_mount_all_raid_disks.sh 
