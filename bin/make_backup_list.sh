ls |tr '\t' '\n'|sed -e 's/^/backup_domain\.sh /g' > test2.txt
 ls |tr '\t' '\n'|sed 's/^/echo \"/g;s/$/\";/g' > test1.txt
 paste test1.txt test2.txt > ./backup_all_subdir.sh 


emacs ./backup_all_subdir.sh

 


