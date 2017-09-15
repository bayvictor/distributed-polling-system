#wordfreq_lowercase $1 |  sed -e 's|^\s*[0-9][0-9.]* ||g'  > $1.out
wordfreq_lowercase $1   > $1.out
 
/home/vhuang/bin/filter_by_stopwords.py -k $1.out  -s /home/vhuang/Documents/stopword_list.txt | grep -ve "^[0-9.][0-9.]*$" | grep -ve "^[0-9.][0-9.]*\s*$"
