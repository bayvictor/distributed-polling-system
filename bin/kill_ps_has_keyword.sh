echo "usage:$0 <kill_keyword_in_ps_ef>"
echo ".e.g.: $0 firefox"
echo "^C to break, anykey to continue...";read readline
echo "below ps -ef results will be killing...";read readline2

ps -ef | grep $1


echo "^C to break, anykey to continue...";read readline
#ps -ef|grep wget |tr '\b' ' '|cut -d" " -f4-9|sed 's/^ *//g'|cut -d" " -f1|sed 's/^/kill -9 /g' 

ps -ef|grep $1|tr '\b' ' '|cut -d" " -f4-9 | sed 's/^ *//g' | cut -d" " -f1|sed 's/^/kill -9 /g' > ./run.sh 
chmod +x *.sh

./run.sh 


