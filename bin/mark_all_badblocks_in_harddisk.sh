 ~/bin/umount_dir_4_UUID.sh

  blkid|cut -d":" -f1|sed -e "s|^|sudo badblocks -t 0 -b 512 -n -v |g;s|$| > |g" > /tmp/test01.txt
  cat /tmp/test01.txt|sed -e 's|[^0-9a-zA-Z]|_|g;s|$|.log.txt|g;s|^| /tmp/|g' > /tmp/test02.txt
  cat /tmp/test02.txt|sed -e "s|^|echo \"writing \"|g;s|$|....\";|g" > /tmp/test023.txt  
 paste /tmp/test023.txt /tmp/test01.txt /tmp/test02.txt >/tmp/batch_badblocks.sh
  chmod +x /tmp/*.sh
/tmp/batch_badblocks.sh
cat /tmp/test02.txt | sed 's|^|sudo fsck -t ext4 -l |g' >/tmp/test03.txt
  cat /tmp/test02.txt|sed -e "s|^|echo \"fsck disks with \"|g;s|$|....\";|g" > /tmp/test033.txt  
paste /tmp/test033.txt /tmp/test03.txt /tmp/test01.txt > /tmp/check_all_harddisk_badblocks.sh 
  chmod +x /tmp/*.sh
 /tmp/check_all_harddisk_badblocks.sh 


