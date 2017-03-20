yum search $1  | sed 's/^/sudo yum install -y /g;s/ : /;#  : /g' 
