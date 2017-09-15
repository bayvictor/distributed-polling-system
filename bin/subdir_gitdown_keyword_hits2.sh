echo "$0 <keyword_list.txt>"
echo "e.g.: $0 ../volvo.kw.txt "
echo "^c to break, anykey to continue...."; read readline
export keywordlist_fn=$1

cat $keywordlist_fn  |sed 's/^/echo \"/g;s/$/\";/g'> ../test01.txt
cat $keywordlist_fn  |sed 's/^/cat /g;s/$/\//g'> ../test021.txt
cat $keywordlist_fn  |sed 's/$/1.html \x7c grep We.*found /g'> ../test022.txt

paste ../test01.txt ../test021.txt ../test022.txt |tr '\t' '\/' | sed -e 's|/cat |cat |g;s|//|/|g'>../found_hits.sh
chmod +x ../*.sh
vi ../found_hits.sh
echo "^c to break, anykey to continue...."; read readline
../found_hits.sh
