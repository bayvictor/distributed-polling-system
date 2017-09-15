sudo apt-get install imagemagick -y 
echo "cd jpg_dir, then it reducing everyfile to new size"
echo "usage: $0 <dir_name>"
echo "^c to break, anykey to contiue..."; read readline

cd $1 

#cd '/home/vhuang/Documents/_201209jobs/job-descriptions/embedded_resource_group/signed_agreement_btw__Geniefair_INC_and_ERG_INC_soft_copy' 

mogrify -resize 50% -format jpg *

