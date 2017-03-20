echo "usage $0 <word>"
# aptcache2get.sh $1 | grep $1 


apt-cache search $1 |sed 's/ - / #- /g;s/^/ sudo apt-get install -y --force-yes /g' > /tmp/go.sh 
echo "" >> /tmp/go.sh
echo "" >> /tmp/go.sh

echo "" >> /tmp/go.sh
chmod +x /tmp/go.sh

gedit /tmp/go.sh &

echo "^C to break, anykey to execute above code -- your just edit & save"
read readline

/tmp/go.sh
cp /tmp/go.sh ~/diary/done-apt-get__relative-to-$1__semantic-`timestamp`.txt

chmod +x ~/bin -R



