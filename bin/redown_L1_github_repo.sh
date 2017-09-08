echo "unset CUR;export CUR=$PWD" > github_level1_redown.sh
 

tree -d -L 1|cut -d" " -f2|sed '$d' | sed '$d;1d'|sed 's|^|~/bin/github_down_n_gen_most_stars_ranking.sh |g;s|$| 5 30 2  4 |g' >>   github_level1_redown.sh

chmod +x *.sh
vi github_level1_redown.sh
echo "^C t obreak , anykey to continue..."; read readline
./github_level1_redown.sh


