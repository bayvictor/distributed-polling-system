#grep -rl oldstr path | xargs sed -i 's/oldstr/newstr/g' /dev/null
echo "usage: $0 <oldstr> <newstr>"

grep -rl $1 .  | xargs sed -i 's/$1/$2/g' /dev/null


