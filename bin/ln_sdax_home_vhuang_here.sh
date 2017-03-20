echo "$0 <diskid>"
echo "e.g.: 
$0 sda9
"
echo "^C to break, anykey to continue...";read readline   #"

  ls /$1/home/vhuang/ | tr '\t' '\n' > test01.txt
  cat test01.txt|sed 's|^|ln -s /$1/home/vhuang/|g;s/$/ /g' > test02.txt
 paste test02.txt test01.txt > ln_$1_all_here.sh
chmod +x *.sh
./ln_$1_all_here.sh 

