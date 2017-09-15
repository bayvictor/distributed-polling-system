echo "converting ppt to pptx"
echo "$0  <ppt_fn>"
echo "e.g.: $0 test.ppt"
echo "^C to break, anykey to continue...";read readline

export filename=$1
libreoffice --headless --convert-to pptx $filename
~/bin/pptx2txt.sh -v $filename.pptx

