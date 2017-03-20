df -h|sed '1,8d'| cut -d"%" -f2 >aldisks_list.txt
  cat alldisks_list.txt |sed "s|^| mkdir /mnt/"$HOSTNAME"/|g" | sed 's|/ /|/|g' >all_mkdir.sh
  cat alldisks_list.txt |sed "s|^| chown vhuang /mnt/"$HOSTNAME"/|g" | sed 's|/ /|/|g' >all_chown.sh
  cat alldisks_list.txt |sed "s|^|sshfs  -o follow_symlinks -o idmap=user "${USER}"@"$HOSTNAME":/|g" | sed "s|$|/home/"$USER" |g" |sed 's|/ /|/|g' >all_sshfs_mount.sh
  cat alldisks_list.txt |sed "s|^|  /mnt/"$HOSTNAME"/|g" | sed 's|/ /|/|g' >all_tail.sh
  paste all_sshfs_mount.sh all_tail.sh > all_mount_once.sh
  chmod +x *.sh
  sudo chmod +x *.sh
  echo "sudo mkdir /mnt/"$HOSTNAME > all_outsider.sh
  echo "sudo chown $USER /mnt/"$HOSTNAME >> all_outsider.sh
  cat ./all_mkdir.sh >> all_outsider.sh
  cat ./all_chown.sh >> all_outsider.sh
  cat ./all_mount_once.sh >> all_outsider.sh
  echo "all scripts in \"all_ousider.sh\"!"
  echo "^C to break, anykey to view generated all_outsider.sh";read readline

  cat  all_outsider.sh

~ 
