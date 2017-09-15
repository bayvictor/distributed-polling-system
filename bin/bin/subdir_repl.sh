#grep -rl oldstr path | xargs sed -i 's/oldstr/newstr/g' /dev/null
echo "usage: $0 oldstr newstr filename_inc_filter fn_outfilter"
echo "e.g.:  $0 \"\/home\/vhuang\" \"\${HOME}\" \"\.la\$\"  \"\.a\$\" " 
echo "replace for \".la\" but don't repl on \"\.a\" file!"
read readline
grep -rl $1 . | grep -e $3 | grep -ve $4 | xargs sed -i -e 's/$1/$2/g' #> /dev/null

