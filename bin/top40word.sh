 cat  $1 |head -n 40 | cut -d"," -f1|wordfreq |sed 's/^ *[0-9]*//g'| tr '\n' '\t'

