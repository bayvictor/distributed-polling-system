#/bin/bash  
echo "usage:$0 <file_ext>"
echo "e.g.: $0 java,     anykey to go,^c to break"
read read_line

find |grep -e "\.$1\$"|xargs etags -a
