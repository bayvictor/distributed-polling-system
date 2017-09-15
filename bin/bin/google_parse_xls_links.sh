cat $1 | sed 's|http://|*@|g'|tr '@' '\n;ss|\*|http://|g' | grep ">" | grep -v "Undo <#>" | grep -v "<javascript:void(0)" | grep ">$" | grep -v -e "^webcache.googleusercontent.com"|grep  -v "^<" | grep -v "^ " | sed  -e 's/\< *$//g' | tr '>' ' ' | grep -v "^scholar.google.com"  

