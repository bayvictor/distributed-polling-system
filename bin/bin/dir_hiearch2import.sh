
echo "convert dir frame($1) into a import a.b.c.d etc for java/python/ etc"

echo "$1"|sed 's/\//\./g;s/^/import /g;s/$/;/g'


