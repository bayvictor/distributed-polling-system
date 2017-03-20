#bunzip2 -c < file.tar.bz2 | gzip -c > file.tar.gz
bunzip2 -c < $1.tar.bz2 | gzip -c > $1.tar.gz
