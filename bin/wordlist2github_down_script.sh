echo "usage:$0 <filename>"
echo "e.g.:   $0 ~/Documents/twitter_related_cpc_desc.txt            "
echo "ctrl-C to break, anykey to continue...";read readline 

cat $1|sed 's|^| /home/vhuang/bin/github_down.py \"|g;s|$|\" 5 30 5|g' > $1.github.zip.down.sh
chmod +x *.sh
cat $1.github*.sh | head
 
