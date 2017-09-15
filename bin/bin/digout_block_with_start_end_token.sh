echo "usage:$0 <filename> <block_start_re_token> <block_end_re_token>"
echo "e.g.: $0 aliyah.wishlist.txt \"Wish List	[0-9]\" \"\< prev   next \>\"   "
echo "where re: regular expression"
echo "^C to break, any other key to continue...";read readline

cat $1 | tr '\n' ' ' | sed -e 's|$2|@|g' | tr '@' '\n' | sed -e 's|$3|@|g' | cut -d"@" -f1 > $1.out


