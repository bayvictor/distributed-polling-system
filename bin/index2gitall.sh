
#$ cat index.html  | grep v-align-middle | cut -d'"' -f2|sed 's|^|git clong http
#s://github.com|g;s|$|.git|g' >gitall.sh

# cat $1 | grep v-align-middle | cut -d'"' -f2|sed 's|^|git clone https://github.com|g;s|$|.git|g;s|https://github.comhttps://github.com|https://github.com|g;s|clone https|clone git|g' >>gitall.sh


 cat $1 | grep v-align-middle | cut -d'"' -f2|sed 's|^|git clone https://github.com|g;s|$|.git|g;s|https://github.comhttps://github.com|https://github.com|g' >>gitall.sh


