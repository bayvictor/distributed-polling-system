#cat TheRole.htm |grep http | grep github | cut -d":" -f2|cut -d'"' -f1 | grep TheRole 
cat $1  |grep http | grep github | cut -d":" -f2|cut -d'"' -f1 |  grep stargazers | sed 's/\/stargazers$/\.git/g;s/^/https:/g'  

