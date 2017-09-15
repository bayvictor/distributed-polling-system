
#cat recruit.801adwords.sh |sed 's|^| /home/vhuang/bin/github_down.py "|g;s|$|"  5 30 5|g'
cat $1 |sed 's|^| /home/vhuang/bin/github_down.py "|g;s|$|"  5 30 5|g'
