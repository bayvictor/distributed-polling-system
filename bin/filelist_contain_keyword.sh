#grep "\.samsung.msca.." * -R |grep -ve "^Binary" | grep -ve "^TAGS\:" |cut -d":" -f1|uniq
echo "usage: $0 <keyword>"
echo "e.g. $0 \".samsung.msca.\""
echo "^C to break, anykey to continue...";read readline

grep -e "$1" * -R |grep -ve "^Binary" | grep -ve "^TAGS\:" |cut -d":" -f1|uniq

