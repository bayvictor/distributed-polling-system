tree -d -f -L 1|cut -d" " -f2|sed '1d;$d' > test01.txt 

 cat test01.txt|sed 's/^/echo \"/g;s/$/\";/g'>test00.txt
    cat test01.txt|sed 's/^/cd \"/g;s|$|\";source ~/bin/ndkgo.sh|g;s|$|;cd ..;|g'>test02.txt
paste test00.txt test02.txt >build_all_ndk_samples.sh
chmod +x *.sh
gedit build_all_ndk_samples.sh

./build_all_ndk_samples.sh


