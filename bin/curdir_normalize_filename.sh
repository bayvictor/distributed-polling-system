find . -type f -print0 | while IFS= read -r -d '' filename; do echo ${filename##*/}; done >../test01.txt
cat ../test01.txt|sed 's|^|"|g;s|$|" |g;s|^|mv |g' > ../test012.txt
cat ../test01.txt | sed  's|[^0-9a-zA-Z_\.\-]|_|g' > ../test013.txt
paste ../test012.txt ../test013.txt > go.sh
chmod +x *.sh
#cat go.sh|head 
./go.sh

