  tree -d -L 1|cut -d" " -f2 |sed '$d'|sed '$d' > test01.txt
  cat test01.txt|sed 's/^/echo \"/g;s/$/\";/g'>test012.txt

#  cat test01.txt|sed 's/^/cd  \"/g;s|$|\";/home/vhuang/bin/curdir_cp_downthemall_filename_to_newdir_with_shorten_name.py;mkdir long_fn; mv \* long_fn;mv long_fn/subdir_shorten_fn . ; cd ..;|g'>test013.txt

  cat test01.txt|sed 's/^/cd  \"/g;s|$|\";/home/vhuang/bin/curdir_cp_downthemall_filename_to_newdir_with_shorten_name.py; cd ..;|g'>test013.txt

  paste test012.txt test013.txt |sed '1d' > subdirs_shorten.sh
  chmod +x *.sh
  gedit  ./subdirs_shorten.sh
  echo "^C to break, anykey to continue shortening subdir filenames";read readline

  ./subdirs_shorten.sh


