echo "$0 <filename> <splited_lines_each_segment>"
echo "e.g.:  $0 splitfire.sh 15"
echo "^C to break, anykey to continue...";read readline

split -l 15 $1

  ls x??|tr '\b' '\n'>test.txt
  cat test.txt |sed 's/$/\.sh /g'>test02.txt
  cat test.txt |tr '\b' '\n'|sed 's/^/mv  /g'>test01.txt
  paste test01.txt test02.txt > testgo.sh
  chmod +x *.sh
  ./testgo.sh
  chmod +x *.sh

echo "all segments generated as below:"
ls x??.sh


