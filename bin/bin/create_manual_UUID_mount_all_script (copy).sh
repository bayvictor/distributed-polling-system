#!/bin/bash

 sudo blkid | grep -v "/dev/sda8" | cut -d":" -f1|cut -d"/" -f3|sed 's/^/sudo umount \//g' > umount_dir_4_UUID.sh
 sudo blkid | grep -v "/dev/sda8" | cut -d":" -f1|cut -d"/" -f3|sed 's/^/sudo mkdir \//g' > generate_dir_4_UUID.sh




chmod +x *.sh

./umount_dir_4_UUID.sh
./generate_dir_4_UUID.sh

sudo blkid | grep -v "/dev/sda8" | cut -d":" -f1|cut -d"/" -f3|sed 's/^/ \//g' > seg02.txt
sudo blkid | grep -v "/dev/sda8" | sed 's/UUID=\"/ -U /g;s/\" TYPE=\"/ -t /g;s/\"//g;s/SEC_TYPE=ext2 //g' | cut -d"U" -f2-9| sed 's/^/sudo mount -U /g;s/ -U O  -U / -U /g' >seg01.txt
paste seg01.txt seg02.txt | grep -v swap >  manual_mount_all_UUID.sh
chmod +x *.sh
rm seg01.txt seg02.txt

./manual_mount_all_UUID.sh

