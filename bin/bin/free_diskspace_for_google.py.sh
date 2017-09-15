cd ~/data/google_ca03
ls -ltr >test.txt
    cat test.txt|cut -d":" -f2|cut -d" " -f2 >test01.txt
mkdir  /media/vhuang/data/google_ca032
    cat test01.txt |sed 's/^/mv /g;s|$|  /media/vhuang/data/google_ca032 |g' > free_diskspaces.sh
    chmod +x free_diskspaces.sh 

