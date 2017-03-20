  ls *.warc.gz -lt|cut -d":" -f2|cut -d" " -f2 > test01.txt 
  cat test01.txt | sed 's/^.*_segments_/ /g' > test02.txt
  cat test01.txt |sed 's/^/mv /g;s/$/ /g' >test012.txt
  paste test012.txt test02.txt > renameall.sh
  chmod +x *.sh
  echo "we will process below format batch file:"
  cat renameall.sh |head -n 2 
  echo "......"

  cat renameall.sh |tail  -n 2 

  echo "^C to break, anykey to continue...";read readline
  vi renameall.sh 

  echo "^C to break, anykey to continue...";read readline
  ./renameall.sh

  echo "next ranme to comform the last format used & define in Apr 2016!"

  echo "^C to break, anykey to continue...";read readline

 ls | tr '\t' '\n' > test01.txt
cat test01.txt |sed 's/\_/\-/g' | sed 's|\-warc\-cc\-main\-|__warc__CC\-MAIN\-|g;s|\-warc\-CC\-MAIN\-|__warc__CC\-MAIN\-|g;s|\-\-warc\-\-CC\-MAIN\-|__warc__CC\-MAIN\-|g;' > test02.txt
cat test01.txt | sed 's/^/mv \"/g;s/$/\" /g' >test012.txt
paste test012.txt test02.txt >test03.txt
cat test01.txt |sed 's/^/echo /g;s/$/;/g' >test04.txt
paste test04.txt test012.txt test02.txt > post_renameall.sh
chmod +x *.sh
cat post_renameall.sh |head -n 2
echo "..."
 
cat post_renameall.sh |tail -n 2
echo "^c to break, anykey to continue...";read readline
vi post_renameall.sh

echo "^c to break, anykey to continue...";read readline
./post_renameall.sh




