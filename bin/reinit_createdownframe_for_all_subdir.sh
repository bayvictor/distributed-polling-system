tree -d -L 1|cut -d" " -f2 | sed 's/^/createdownframe /g'|sed '1d;$d'|sed '$d' > re_init_all_subdir.sh
chmod +x *.sh
cat ./re_init_all_subdir.sh
echo "^C to break, anykey to continue batch re init....";read readline

 ./re_init_all_subdir.sh
