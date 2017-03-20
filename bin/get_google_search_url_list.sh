# $0 <saved_google_search_filename>
# out put 100 links of parsed result to stdout    .... 

#cat $1 | sed 's|>Cached</a>|@@|g'|tr '@' '\n' |  sed 's|http://|*@|g'|tr '@' '\n;ss|\*|http://|g' | grep -e "&amp;ct=clnk" | sed 's|&amp;ct=clnk"||g'

## simplicity is beauty!
cat $1  |  sed 's|http://|*@|g'|tr '@' '\n;ss|\*|http://|g' | grep -e "&amp;ct=clnk" | sed 's|&amp;ct=clnk"||g' | sed 's|%2B%3B.*$||g'


