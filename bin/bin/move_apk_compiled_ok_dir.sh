find|grep -e "debug\.apk$" > list_of_compiled_ok.txt
mkdir compiled_error
mkdir compiled_ok

cat list_of_compiled_ok.txt | cut -d"/" -f2 > dirlist_of_compiled_ok.txt
     cat list_of_compiled_ok.txt | cut -d"/" -f2 | sed 's/^/ mv /g;s/$/ compiled_ok /g' > move_all.sh
chmod +x *.sh
./move_all.sh
mkdir compiled_error
#mv * compiled_error
mv compiled_ok ..
 
