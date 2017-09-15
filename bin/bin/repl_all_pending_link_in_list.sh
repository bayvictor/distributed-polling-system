echo "usage $0 <filename_for_replace>"
echo "e.g.:     $0   list.txt  "
echo ""
echo "^C to break, anykey to continue....";read readline


cat  $1  | xargs sed -i 's|/home/fogdev/victor|/home/vhuang|g'
cat  $1  | xargs sed -i 's|/home/vhuang/victor|/home/vhuang|g'
cat  $1  | xargs sed -i 's|/home/fogdev/victor|/home/vhuang|g'
cat  $1  | xargs sed -i 's|/home/vhuang/victor|/home/vhuang|g'
cat  $1  | xargs sed -i 's|/home/vhuang/victor/armroot/|/home/vhuang/armroot/|g'


