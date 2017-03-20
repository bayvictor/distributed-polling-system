cp $1  $1 .`timestamp`

 ./uic_wordfreq.sh $1  > wordfreq.txt
 ./uic_wordfreq.sh $1  | grep "__" > zoic_connections.txt
cat $1  | grep connection -A 10 -B 10 > test.txt.connections.txt
cat $1  | grep -e "slot.*slot"  > test.txt.all-slots.txt

 cat wordfreq.txt |grep "__" | sed -e 's|^\s*[0-9]* ||g' | sed 's|__|@|g' | sed 's|^|<connection><sender>|g;s|@|</sender><signal>clicked()</signal><receiver>|g;s|$|</receiver><slot>show()</slot></connection>|g' | sed 's|</signal><receiver>STF|</signal><receiver>|g' > ui_pluglist_connect.txt

echo "next: in gedit copy-paste all content in \"ui_pluglist_connect.txt\" to $1"
echo "^C to break, anykey to continue...";read readline

gedit ui_pluglist_connect.txt &
gedit $1


