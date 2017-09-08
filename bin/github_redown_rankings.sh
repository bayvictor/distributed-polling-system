    grep github_down_n_gen */*.sh | sed 's/[0-9]$/ 4 /g' >ranking_lines.sh
    cat ranking_lines.sh |sed 's/^/cd /g' >test03.txt
  
  echo "export CUR=\$PWD">test031.txt;cat test03.txt|sed 's|:~/bin/github_down_n_gen_most_stars_ranking.sh |;@|g;s|\/|;|g;s|$|;cd \$CUR;|g;s|@|~/bin/github_down_n_gen_most_stars_ranking.sh |g;s|;.*sh;|;|g' >>test031.txt
 cat  test031.txt |sed 's/^/echo \"/g;s/$/\";/g' >test032.txt
paste test032.txt test031.txt > redown_all_github_subdirs.sh
chmod +x *.sh

vi ./redown_all_github_subdirs.sh
echo "^c to break, anykey to continue...";read readline
 
./redown_all_github_subdirs.sh

