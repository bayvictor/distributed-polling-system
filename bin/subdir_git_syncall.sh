echo "unset CUR;export CUR=$PWD" > sync_subdir_git_repo.sh
 
 find . |grep -e "\.git$"|sed 's/\.git$//g' | cut -d" " -f2|sed '1d;$d'|sed '$d'|sed 's/^/cd /g;s/$/;git pull;cd \$CUR;/g'  >>  sync_subdir_git_repo.sh 
chmod +x *.sh
tree -d -L 1|cut -d" " -f2|sed '$d' | sed '$d;1d'|sed 's|^|~/bin/github_down_n_gen_most_stars_ranking.sh |g;s|$| 5 30 2  4 |g' >>   sync_subdir_git_repo.sh

./sync_subdir_git_repo.sh


