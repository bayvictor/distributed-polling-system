 ls|tr '\t' '\n' > test01.txt
 cat test01.txt |sed 's/^/echo /g;s/$/;cd  /g'>test02.txt
 paste test02.txt test01.txt| sed 's/$/ ;mvn install ;cd \.\. ;/g' > mvn_installall.sh

chmod +x *.sh
gedit mvn_installall.sh
echo "^C to break, anykey to continue....";read readline 

./mvn_installall.sh
 


 
