echo "usage $0 <word>"

apt-cache search $1 |sed 's/ - / #- /g;s/^/ apt-get source /g'i | grep $1  > /tmp/go.sh 
chmod +x /tmp/go.sh
cat /tmp/go.sh
echo "^C to break, anykey to execute above code"
read readline

/tmp/go.sh
cp /tmp/go.sh ~/diary/done-apt-get__relative-to-$1__semantic-`timestamp`.txt






