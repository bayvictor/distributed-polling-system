    find|grep -e "\.git$" > test01.txt
    echo "export CUR=$PWD">test02.txt;cat test01.txt|sed 's/\.git$/;git pull;/g;s/^/cd /g;s/$/cd \$CUR;/g'>>test02.txt;cp test02.txt sync_all.sh;chmod +x *.sh
./sync_all.sh

