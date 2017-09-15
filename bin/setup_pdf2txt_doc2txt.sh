 sudo apt-get install -y --force-yes python-pdfminer #- PDF parser and analyser
 sudo apt-get install -y --force-yes docx2txt #- Convert Microsoft OOXML files to plain text
sudo apt install abiword -y 

echo "from cmd line, doc2txt, 
abiword --to=txt myfile.doc
abiword --to=txt --to-name=output.txt myfile.doc
abiword --to=pdf myfile.doc
soffice --headless --convert-to txt:text file_to_convert.doc
"

docx2txt ~/test.docx  > ~/test.docx.docx2txt.txt 
abiword --to=txt --to-name=~/test.docx.abiword.txt test.docx 
abiword --to=txt --to-name=~/test.doc.txt test.doc
abiword --to=txt --to-name=~/test.pdf.txt test.pdf

echo "working:
catdoc $1 > $1.doc.txt
docx2.txt $1 > $1.docx.txt
pdftotext $1 > hahatest.txt;cat hahatest.txt|sed -e '/^\s*$/d'>$1.pdf2txt.txt
# pdftotext test.pdf hahatest.txt;cat hahatest.txt|sed -e '/^\s*$/d'>test2.txt
html2text $1 >$1.txt
libreoffice --headless --convert-to pptx filename.ppt #ppt to pptx first, then use pptx2txt
./pptx2txt.sh filename.pptx
./pptx2txt.sh [options] PPTX_FILENAME > output.txt
"



