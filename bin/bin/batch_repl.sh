 grep "/home/vhuang//armroot" * -R | cut -d":" -f1 | sort -u > armroot_repl_list.txt

cat armroot_repl_list.txt |  xargs sed -i 's|/home/vhuang//armroot|/home/vhuang/armroot|g'

