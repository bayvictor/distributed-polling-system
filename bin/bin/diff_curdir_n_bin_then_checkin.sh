echo "cd /sdb8/src/victor/distributed-polling-system/bin
"


cd ~/src/victor/distributed-polling-system/bin
  506  cd bin
  507  diff . ~/bin -dup > ../out.txt
  508  vi ../out.txt
  509  cat ../out.txt |grep -e ^Only > ../new.txt
  510  vi ../new.txt
  511  cat ../new.txt|cut -d" " -f2
  512  cat ../new.txt|headd
  513  cat ../new.txt|head
  514  cat ../new.txt|cut -d":" -f2
  515  cat ../new.txt|cut -d":" -f2|sed 's/^/git add /g' > ../addall.sh
  516  vi ../addall.sh 
  517  chmod +x ../*.sh
  518  cat ../addall.sh
  519  cat ../addall.sh|sed 's/^git add /cp /g;s|$| . |g' >../cpall.sh
  520  cat ../cpall.sh 
  521  chmod +x ../*.sh
  522  vi  ../cpall.sh 
  523  cat ../addall.sh|sed 's/^git add /cp ~\/bin\//g;s|$| . |g' >../cpall.sh
  524*   ../cpall.sh 
  525  vi ../addall.sh
  526  ls tarbig*
  527  vi ../cpall
  528  vi ../cpall.sh 


