echo "usage: $0 <keyword_list>"
echo "#e.g.:will do: gen_github_down_script.sh cloud_plus.txt > cloud_plus.txt.sh
"
echo "^C to break, any key to continue....";read readline

gen_github_down_script.sh $1 > $1.sh
chmod +x *.sh

