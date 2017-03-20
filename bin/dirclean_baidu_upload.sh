find | sed 's/^/ \"/g;s/$/\"/g;' > test1.txt 
  find | sed 's/[0-9a-zA-Z_]//g;s/ //g;s/\.//g;s/\-//g;s/$/\.pdf/g;s/\///g' > test2.txt
  paste test1.txt test2.txt |sed 's/^/mv /g' > rename.sh
    chmod +x *.sh
  ./rename.sh 

