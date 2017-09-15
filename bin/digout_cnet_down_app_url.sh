 cat $1 |sed 's|"http://|@^|g;s|"|@|g'|tr '@' '\n'|grep -e "^\^"|sort -u | grep 3000|grep -e "\.html$" | sed "s|^\^|http://|g"

