#cat $1 |sed 's/^/\"/g;s/$/\"/g' |xargs ls -lt >$1.ls
cat $1 |sed 's/^/\"/g;s/$/\"/g' |xargs ls -lt >$1.ls

