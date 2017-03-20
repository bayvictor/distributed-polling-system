#cat ZoicBox_32.ui |grep QTableWidget|sed 's|"QTableWidget" name="|@|g'|cut -d"@" -f2|cut -d'"' -f1 | sort -u
echo "usage: $0 <ui_file>"
echo "e.g.:   $0  ZoicBox_32.ui"
echo "^C to break, anykey to continue..."; read readline
 
cat $1 |grep QTableWidget|sed 's|"QTableWidget" name="|@|g'|cut -d"@" -f2|cut -d'"' -f1 | sort -u


