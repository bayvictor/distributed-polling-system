 ls *.zip |tr '\t' '\n'|sed 's/^/unzip \"/g;s/$/\"/g' > unzipall.sh

