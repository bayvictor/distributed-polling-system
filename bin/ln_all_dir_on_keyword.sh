#!/bin/bash -x 

    if test -z	 "${2}"; then
      if test -z	 "${1}"; then
        echo "$0 <keyword_in_subdir> <new_dir_for_ln_all_withkeyword>"
        echo "$0 voice victordir__for_voice"
	exit 1       echo "$0 ln_all_home_to_bigbase.sh lnall_sdh.sh"
      else
        $2="lnall_"$1
      fi
      exit 1
    fi 



cd ~/src
export CUR=$PWD
mkdir $2
find | grep -e "\.git$" >gitlist.txt
cat gitlist.txt | sed 's|/.git$||g'| grep $1 |cut -d"." -f2 |sed 's|^/||g;s|^| $CUR\/|g;s|^| |g;s|$| |g;' >test01.txt
#tree -d -L 5 -f|grep $1 |cut -d"." -f2 |sed 's|^/||g;s|^| $CUR\/|g;s|^| |g;s|$| |g;' >test01.txt
cat test01.txt|sed 's/^/norm.sh \"/g;s|$|\"|g' >makenorm.sh
chmod +x *.sh
echo "^c to break, anykey to continue...";read readline
./makenorm.sh > test02.txt
export repl="s/^/"$2"\//g"
cat test02.txt|sed $repl >test022.txt
paste test01.txt test022.txt >test03.txt
cat test03.txt|sed 's/^/ln -s /g' >lnall.sh
chmod +x *.sh
echo "^c to break, anykey to continue...";read readline

./lnall.sh


