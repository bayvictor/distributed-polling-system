#convert *.jpg -compress Zip signed_agreement_btw__Geniefair_INC_and_ERG_INC.pdf

echo "e.g.: $0 <pdf_name>"   
echo "^C to break, anykey to continue....";read readline

convert *.jpg -compress Zip $1
 
