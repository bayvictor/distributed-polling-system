mkdir ~/backjars
echo "usage: $0 <path_looking_for_jar>, ^c to break"
read read_line
find $1 |grep "workbench"| find|grep -e "\.jar$"|grep standalone  > temp00.txt
#find $1 |grep "workbench"| find|grep -e "\.jar$"|grep standalone | sed 's/^/"$PWD"/g' > temp00.txt

cat temp00.txt  | sed 's/^/cp -pfr/g' > ~/test02.txt
cat temp00.txt|sed 's/^/cp -p /g;s/$/ /g' >test03.txt


cat temp00.txt  | sed 's/[ :\\\/\"\(\)\{\}]/_/g;s/^\.\_//g;s/^/ ~\/backjars\//g' >temp01.txt

paste test03.txt temp01.txt > batchback_jar.sh
chmod +x batchback_jar.sh
./batchback_jar.sh




