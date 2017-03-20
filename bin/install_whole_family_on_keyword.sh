apt-cache search $1 > /tmp/test33.txt
cat /tmp/test33.txt | sed 's/^/apt-get install -y -y /g;s/ - / #;- /g' > apt-get-family-tree.sh
chmod +x *.sh
./apt-get-family-tree.sh
 




