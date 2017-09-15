 ls|tr '\t' '\n'|sed 's|^| digout_cnet_down_app_url.sh  |g'>digoutall.sh
chmod +x *.sh
./digoutall.sh >all_curdir_urllist.txt 
cat all_curdir_urllist.txt | sed -e "s|[^0-9a-zA-Z]|_|g" > test2.txt
cat  all_curdir_urllist.txt | sed -e "s|^|wget |g;s|$| \-O |g" > test1.txt
paste test1.txt test2.txt > test3.txt

cat test3.txt | sed 's|$|;sleep $[ ( $RANDOM % 15 )  + 1 ]s; |g' > downall_mainapp_page.sh 
chmod +x *.sh
ls -lt *.sh


