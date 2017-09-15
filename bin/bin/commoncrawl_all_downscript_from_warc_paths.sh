echo "usage: $0 <warc_path_url>"

# this script name: ~/bin/commoncrawl_all_downscript_from_warc_paths.sh
#  wget https://aws-publicdatasets.s3.amazonaws.com/common-crawl/crawl-data/CC-MAIN-2015-48/warc.paths.gz

 wget $1 # https://aws-publicdatasets.s3.amazonaws.com/common-crawl/crawl-data/CC-MAIN-2015-48/warc.paths.gz
 gunzip warc.paths.gz
 cat warc.paths.gz | sed 's|^|	wget https://aws-publicdatasets.s3.amazonaws.com/|g' > test02.txt
 cat test02.txt | sed 's|^|echo \"|g;s|$|\";g' > test01.txt







