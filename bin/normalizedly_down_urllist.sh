  echo 
   echo "usage: $0 <raw_url_fn> <wanted_regex> <out_filtered_regex> "
   echo  
   

  echo "^C to break! will do abovE (with 10 headlines display), press anykey to continue..."

 read readline
 if [ -z  "$2" ];then
      if [ -z  "$3" ];then
       cat $1  > ../temp01.txt
     else  
       cat $1 | grep -ve $3 > ../temp01.txt 
     fi  
 else    
     if [ -z  "$3" ];then
       cat $1 | grep -e $2  > ../temp01.txt
     else  
       cat $1 | grep -e $2 | grep -ve $3 > ../temp01.txt 
     fi
 fi 


 cat ../temp01.txt |sed 's/[^0-9a-zA-Z]/_/g;s/$/\.html/g;s/^/ -0 -T 20 /g' > ../temp02.txt
 cat ../temp01.txt | sed 's/^/ wget -U /g' > ../temp001.txt
 paste ../temp001.txt ../temp02.txt > ../temp03.txt.sh 
 chmod +x ../*.sh

 cat ../temp03.txt.sh | head 

  echo "^C to break! will do abovE (with 10 headlines display), press anykey to continue..."

 read readline

../temp03.txt.sh   
 

