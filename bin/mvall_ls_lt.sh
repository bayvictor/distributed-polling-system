cat ~/defect_list.sh |cut -d":" -f2|cut -d" " -f2 |sed 's|^|mv |g;s|$| /sdo/new_ccawl_nov2015/ |g'>~/mvall.sh
chmod +x ~/*.sh 
~/mvall.sh

