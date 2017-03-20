echo "#usage:$0 <bare_txt_filename>"
echo "#e.g.:   $0 swplus.txt.keeporder.uniq.txt "

cat $1 | sed -e 's|^|github_down.py \"|g;s|$|\" 3 45 3 |g' 
