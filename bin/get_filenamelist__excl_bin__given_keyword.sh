#  grep -e  "\bwork1\b" * -R | cut -d":" -f1 | grep -ve "^Binary file"
  grep -e  "\b$1\b" * -R | cut -d":" -f1 | grep -ve "^Binary file"


