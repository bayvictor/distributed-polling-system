echo "usage:$0 <bare_txt>"
echo "e.g.: $0 lidar-notes.txt"
echo "^C to break, anykey to continue...";read readline
 
 lower_wordfreq_sort_gt2.sh $1 >test.txt
 cat test.txt|sort -u >test2.txt
  filter_by_stopwords.py -k test2.txt -s ~/bin/stopwords.txt >test3.txt

cp test3.txt $1.w1



