# cat 6009603948.html|sed 's/[^0-9]/ /g'|tr ' ' '\n'| egrep -e '^[0-9]{10}$'
echo "usage:$0 <data_filename>"
echo "e.g:"
echo "$0  6009603948.html"
echo ""
echo "^C to break, any key to continue...."; read readline

cat $1 | sed 's/[^0-9]/ /g'|tr ' ' '\n'| egrep -e '^[0-9]{10}$'

