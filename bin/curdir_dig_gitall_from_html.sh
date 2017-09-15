ls *.html|tr '\t' '\n'|sed 's/^/\.\/index_to_gitall.sh /g' >go.sh
 chmod +x go.sh
./go.sh

chmod +x *.sh

vi gitall.sh
echo "^C to break, anykey to continue....";read readline
./gitall.sh


