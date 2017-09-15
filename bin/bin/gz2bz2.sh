#gunzip -c < file.tar.gz | bzip2 -c > file.tar.bz2

gunzip -c < $1.tar.gz | bzip2 -c > $1.tar.bz2
