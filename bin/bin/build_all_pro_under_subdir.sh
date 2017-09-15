WORK_DIR=build-`timestamp`
mkdir $WORK_DIR
cd $WORK_DIR
  find .. |grep -e "\.pro$" | sed 's/^/qmake /g;s/$/ /g' > ../test.txt 
 find .. |grep -e "\.pro$" | sed 's/\.pro$//g'|sed 's/^/norm.sh /g' > ../test2.sh
chmod +x ../*.sh
 ../test2.sh|sed 's/^\./ -o Makefile/g' >../test02.txt

 paste ../test.txt ../test02.txt > make_all_Makefile.sh

chmod +x *.sh


  cat ../test02.txt |sed 's/-o/make -f/g;s/$/;sudo make install;/g' >>make_all_Makefile.sh 

echo "this is the content of make_all_Makefile.sh"
cat  make_all_Makefile.sh

echo "^C to break, any key to run make_all_Makefile.sh"
read readline

./make_all_Makefile.sh
 
