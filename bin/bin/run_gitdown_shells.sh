ls *.sh|tr '\t' '\n'|sed 's/^/\.\//g' > ./runrun.sh
chmod +x *.sh
./runrun.sh
 
