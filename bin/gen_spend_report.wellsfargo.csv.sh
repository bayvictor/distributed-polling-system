echo " do something like: cat gnf_Checking2013.csv|grep "2013",\"\-" >gnf_checking2013.spend.csv "   

echo "^C to break, anykey to continue...";read readline
cat $1 | grep "2013",\"\-" > spending.$1.csv



