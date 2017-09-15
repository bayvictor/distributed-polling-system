   find|grep debug.apk >apklist.txt
   cat apklist.txt |sed 's/^/adb install /g' >installall.sh

   chmod +x *.sh
   chmod +x ~/bin -R 
   ./installall.sh
 
