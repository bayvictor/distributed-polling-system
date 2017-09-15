 find|grep -e "\.git$" >gitlist.txt
echo "export CUR=\$PWD">go.sh;cat gitlist.txt | sed 's/\.git$//g'|sed 's/^/cd /g;s/$/;git pull;cd $CUR;/g'>>go.sh
chmod +x go.sh
./go.sh
 
