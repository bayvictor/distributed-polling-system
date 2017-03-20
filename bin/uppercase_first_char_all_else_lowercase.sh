# cat top_surnames.txt |sed 's/^\(.*\)$/\L\1/g' | sed 's/^\(.\)/\U\1/g'

 cat $1 |sed 's/^\(.*\)$/\L\1/g' | sed 's/^\(.\)/\U\1/g'

