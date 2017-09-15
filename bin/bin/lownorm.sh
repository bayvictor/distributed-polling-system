cat $1 |tr '[A-Z]' '[a-z]'|sed 's/[^a-zA-Z0-9]/_/g'

