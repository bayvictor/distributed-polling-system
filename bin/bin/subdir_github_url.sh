 cat *.html| grep "^ *<a href="|grep stargazers\"|tr '"' '\n'|grep -e "stargazers$"|sed -e 's|^|https://github.com/|g;s|/stargazers$|/archive/master.zip|g'|sed -e 's|^|<a href="|g;s|$|">1</a>|g'


