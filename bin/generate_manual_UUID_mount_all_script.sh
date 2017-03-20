#!/bin/bash

 sudo blkid | cut -d":" -f1|cut -d"/" -f3|sed 's/^/sudo umount \//g' > umount_dir_4_UUID.sh
 sudo blkid | cut -d":" -f1|cut -d"/" -f3|sed 's/^/sudo mkdir \//g' > generate_dir_4_UUID.sh




chmod +x *.sh

./umount_dir_4_UUID.sh
./generate_dir_4_UUID.sh

sudo blkid | cut -d":" -f1|cut -d"/" -f3|sed 's/^/ \//g' > seg02.txt
sudo blkid | sed -e 's/ PTUUID=\"[0-9]*\" //g'| sed 's/ PARTLABEL=.*$//g'| sed 's/ PARTUUID=.*$//g'|sed 's/UUID=\"/ -U /g;s/\" TYPE=\"/\" -t /g;s/\"//g;s/SEC_TYPE=ext2 //g' | cut -d"U" -f2-9| sed 's/^/sudo mount -U /g;s/ -U O  -U / -U /g' >seg01.txt
cat seg01.txt|sed 's/-l -L \w+ \-t/\-t/g;s/LABEL=.*\-t/ -t/g' > seg012.txt

paste seg012.txt seg02.txt | grep -v swap >  manual_mount_all_UUID.sh
chmod +x *.sh
rm seg01.txt seg02.txt

./manual_mount_all_UUID.sh

