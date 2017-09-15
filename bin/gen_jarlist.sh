 ls  ~  |grep workspace | sed 's/^/find /g;s/$/ \|grep -e \"jar$\" >>jar_list.txt /g'

