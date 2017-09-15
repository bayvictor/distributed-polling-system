 curdir_cp_downthemall_filename_to_newdir_with_shorten_name.py py
  mkdir subdir_long_fn
 mv * subdir_long_fn/
 cd subdir_long_fn/
 mv subdir_shorten_fn/ ..
 cd ..
 cd subdir_shorten_fn/
 rm TAGS -fr
 find | xargs etags -a
 echo "^C to break, anykey to continue to emacs for tag search, then do something like \"python 099_203.py\" later, test downed program one by one...";read readline

 emacs &
# python 066_203.py > 099_203.py.log
sudo chown vhuang /home/vhuang/.cache -R


