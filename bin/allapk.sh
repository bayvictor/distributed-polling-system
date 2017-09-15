ls |tr '\t' '\n'|sed 's/^/subdir_git_apk.sh /g' >  all_make_apk.sh
chmod +x *.sh
gedit  all_make_apk.sh
./all_make_apk.sh



