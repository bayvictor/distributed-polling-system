#~/src/proxy_lists$ 

basefile=`timestamp`.txt
tmpfile=/tmp/$basefile
wget http://proxies.my-proxy.com/ -O $tmpfile 
cat $tmpfle  | sed  's/\<br\>/@/g' | grep '@'|grep -e "[0-9].[0-9]"|tr '@' '\n' | grep -e "[0-9].[0-9]"| tr "<" " "|tr ">" " " >  ~/src/proxy_lists/$basefile
#rm -fr $tmpfile
cat  ~/src/proxy_lists/$basefile

#cacheproxy $1  -O ~/src/proxy_lists/`timestamp`.txt
