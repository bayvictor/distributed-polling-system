unset TARGET_DIR
#export TARGET_DIR=/media/vhuang/data/google50 
export TARGET_DIR=/sdp5/google50 
mkdir $TARGET_DIR  
ls -ltr|grep +|cut -d":" -f2|cut -d" " -f2 |sed "s/^/mv /g;s|$| $TARGET_DIR |g" > ../test01.txt 
cat ../test01.txt | sed 's/^/echo \"/g;s/$/\";/g' > ../test011.txt
echo "unset TARGET_DIR                                                                
   export TARGET_DIR=${TARGET_DIR} 
   mkdir $TARGET_DIR
   "> mvall.sh

paste ../test011.txt ../test01.txt >> mvall.sh
chmod +x *.sh
vi  ./mvall.sh
echo "^c to break, anykey to continue..."; read readline

 ./mvall.sh

