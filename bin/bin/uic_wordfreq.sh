#cat ZoicBox_28.ui | tr -c 'A-Za-z0-9-\._' '\n' | sort  | uniq -c |  sort -g -r 
# including underscore
cat $1 | tr -c 'A-Za-z0-9-\._' '\n' | sort  | uniq -c |  sort -g -r 

