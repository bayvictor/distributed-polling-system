  blkid|cut -d":" -f1 >~/test01.txt
  cat ~/test01.txt|cut -d"/" -f3|sed 's/^/ \//g;s/$/ /g' > ~/test02.txt
  paste ~/test01.txt ~/test02.txt |sed 's/$/    ext4    errors=remount-ro 0       1 /g' > ~/fstab_list.txt
  cat ~/test02.txt |sed 's/^/sudo mkdir /g' >~/bin/mkdir_all_dev_sdx_list_map.sh
chmod +x ~/bin -R
 cat ~/bin/mkdir_all_dev_sdx_list_map.sh



