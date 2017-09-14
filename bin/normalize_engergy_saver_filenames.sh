  find >fnlist.txt

    cat fnlist.txt|sed 's/[^a-zA-Z0-9]/_/g'|sed 's/^__*//g'|sed 's/_zip$/.zip/g;s/_csv$/.csv/g;s/^/ /g;s/$/ /g' >test01.txt
    paste test02.txt test01.txt >renameall.sh

