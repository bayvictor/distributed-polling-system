echo "usage:$0 <fromdir> <todir>"
echo "e.g.:   $0  ~/src/_recruit/compiling/android+launcher  /media/vhuang/1A86-2F29/apks/_launcher "
echo "^C to break, anykey to continue..."; read readline

tail=`echo ${1} | tr '\/' '\n'|tail -n 1`


mkdir /media/vhuang/1A86-2F29/apks/${tail}
mkdir $2
#mkdir /media/vhuang/1A86-2F29/apks/_wallpaper

cd $1
  find | grep -e "debug\.apk$" > apklist.txt
  cat apklist.txt |sed 's|[^a-zA-Z0-9]|_|g;s|^__unzip_||g;s|_apk$|\.apk|g' > test02.txt
cat apklist.txt | sed 's|^|cp '$1'\/|g;s|/./|/|g' > test01.txt 
cat test02.txt | sed 's|^| '$2'\/|g' > test022.txt
paste test01.txt test022.txt > /tmp/cpall.sh
chmod +x /tmp/*.sh
cat /tmp/cpall.sh|head
 /tmp/cpall.sh



