ps -ef|grep wget |tr '\b' ' '|cut -d" " -f4-9|sed 's/^ *//g'|cut -d" " -f1|sed 's/^/kill -9 /g' > ./killallwget.sh 
chmod +x *.sh
./killallwget.sh

#/home/vhuang/bin/kill_ps_has_keyword.sh wget
