mkdir pdfs 
cd pdfs 
 mogrify ../*  -format pdf
 ls *.pdf 
 cd ..
 pdftk pdfs/*.pdf cat output singlename.pdf
  ls single*.pdf
 
