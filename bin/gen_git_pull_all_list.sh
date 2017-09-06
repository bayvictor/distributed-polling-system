echo "unset CUR;export CUR=$PWD" 
 find . |grep -e "\.git$"|sed 's/\.git$//g' | cut -d" " -f2|sed '1d;$d'|sed '$d'|sed 's/^/cd /g;s/$/;git pull;cd \$CUR;/g'
chmod +x *.sh

