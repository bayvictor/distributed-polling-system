 cat *.html|grep -e '" href="'|grep stargazers|cut -d'"' -f4|sed -e 's|/stargazers$|.git|g'|sed 's|^|git://github.com/|g' | sed 's/^/git clone /g'


