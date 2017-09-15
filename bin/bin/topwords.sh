 cat  $1 |head -n $2 | cut -d"," -f1|wordfreq |sed 's/^ *[0-9]*//g'| tr '\n' '\t'

