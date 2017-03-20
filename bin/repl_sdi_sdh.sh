#!/bin/bash -x 
echo "pointing all home dir to this drive!"
echo "e.g.: $0 lnall_sdh.sh"
echo "or: e.g.: $0 lnall_sdh.sh" 
echo "^c to break, anykey to continue...";read readline

    if test -z	 "${2}"; then
      if test -z	 "${1}"; then
        echo "$0 <ln_all_fn> <new_fn>"
        echo "$0 ln_all_home_to_bigbase.sh lnall_sdh.sh"
	exit 1
      else
        sed -i 's/sdi/sdh/g' $1
        exit 0
      fi
    else 
      cp $1 $2
      sed -i 's/sdi/sdh/g' $2
      exit 0 
   fi
chmod +x *.sh

ls *.sh -lt|head
echo "^c to break, anykey to run generated shell ($2)...";read readline
./$2

