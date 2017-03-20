  tree -d -L 1|cut -d" " -f2|sed '1D;$D' | sed '$D;s|^|cd |g;s|$|;~/bin/curdir_cp_down*.py;cd ..|g' > do_curdir.sh
  chmod +x *.sh
  ./do_curdir.sh 

