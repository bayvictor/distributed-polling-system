  tree -d -L 1 -f | cut -d" " -f2 | sed '1d' > test01.txt
  cat test01.txt | sed 's/^/\"/g;s/$/\";/g' > test02.txt
 cat test02.txt|  sed 's/^\"/echo \"making .../g' > test022.txt 
  cat test02.txt|  sed 's/\"\.\//cd  \"\$CUR\//g;s/$/subdir_make_apk.py android-17 /g' > test023.txt 


cat test02.txt |  sed 's/^\"/echo \"processing .../g;s|$|\"$|\"\>current.log.txt;|g' > test024.txt  

  echo "unset CUR;export CUR=\$PWD" > curmake_all.sh
 paste test024.txt test022.txt test023.txt | sed '$d' >> curmake_all.sh
 chmod +x ~/bin -R
 chmod +x *.sh
gedit ./curmake_all.sh
echo "press ^C to break, anykey to continue...";read readline

  ./curmake_all.sh


