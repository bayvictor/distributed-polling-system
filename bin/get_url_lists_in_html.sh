cat $1 | sed -e 's|http://|^@|g'|tr '^' '\n'| grep -e '^@'| sed -e 's|\x27|\"|g;s|[\\"\\) \\<]|^|g' | cut -d'^' -f1 | sed -e 's|^@||g'  | sort -u 
 

