#gunzip --to-stdout foo.gz | bzip2 > foo.bz2
gunzip --to-stdout $1.gz | bzip2 > $1.bz2
