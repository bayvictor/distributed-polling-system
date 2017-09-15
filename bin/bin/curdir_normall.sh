/home/vhuang/bin/subdirlist.sh > ../test01.txt
cat ../test01.txt | sed 's|^|cd |g;s|$|;/home/vhuang/bin/curdir_normalize_filename.sh;/home/vhuang/bin/subdir_html2txt.py;cd ..|g' > go.sh
cat go.sh|head 
chmod +x *.sh
./go.sh


