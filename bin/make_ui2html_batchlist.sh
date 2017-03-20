echo "usage:$0 <path_of_ui_files>"
echo "e.g.:  $0 \"~/src/3d/zoicbox34-02\""
echo "^C to break, anykey to continue...";read readline

echo "ls $1/   ...:"
ls $1/
ls $1/*.ui|tr '\t' '\n' >test00.txt
cat test00.txt |sed 's|^|python ../src/ui-html.py |g' > test01.txt
cat test00.txt|sed 's/$/\.html/g;s/^/ /g'>test03.txt
paste test01.txt test03.txt > batch_ui2html.sh
gedit batch_ui2html.sh
chmod +x *.sh 
echo "^C to break, anykey to continue...";read readline

./batch_ui2html.sh


