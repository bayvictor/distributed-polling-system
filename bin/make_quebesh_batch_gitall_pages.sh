echo "save qebesh code home page in Qubeship*.html first! ^C to break, anykey after saving web code page"; read readline

#   48  [2016-09-06 13:45:28
 cat Qubeship*.html |sed 's/href/@/g'|tr '@' '\n'|grep -i qubesh >list_quebeship.txt
#   57  [2016-09-06 13:50:18
 cat list_quebeship.txt | grep -i item | cut -d'"' -f2 |sed 's/^/git clone /g;s/$/\.git/g' >gitall.sh
#   58  [2016-09-06 13:50:23
 chmod +x gitall.sh
#   59  [2016-09-06 13:50:25
 vi gitall.sh 
#   60  [2016-09-06 13:50:43
 chmod +x *.sh
#   61  [2016-09-06 13:50:43
echo "^C to break, anykey to contiue..."; read readline 
#   62  [2016-09-06 13:50:48
 ./gitall.sh 
#   65  [2016-09-06 13:53:51
# history|sed 's/^/#/g;s/\
#/\n/g' > autoall.sh
