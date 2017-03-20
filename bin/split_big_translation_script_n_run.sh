  mkdir data_all2006
  cp all2006ow_bare0.txt.en2ch.sh data_all2006/
cd data_all2006
split -l 20000 all2006ow_bare0.txt.en2ch.sh 

  ls|tr '\t' '\n' >../test1.txt
  cat ../test1.txt|sed 's|^|./|g;s|$| |g' >../test11.txt
  cat ../test1.txt|sed 's|^| > |g;s|$|.log.txt|g' >../test12.txt
  paste ../test11.txt ../test12.txt |head
  paste ../test11.txt ../test12.txt > ../test3.txt
  cat ../test3.txt |sed 's/^/echo \"/g;s/$/\";/g' >../test30.txt
  paste ../test30.txt ../test3.txt >run.sh
  chmod +x *.sh
  vi run.sh 
echo "^C to break, anykey to run auto-translation big batch...";read readline
./run.sh 


