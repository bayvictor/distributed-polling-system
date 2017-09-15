#egrep '\(?[0-9]{3}[ )-]?[0-9]{3}[ -]?[0-9]{4}' file_contain_all_form_of_phone_numbers.txt 
#egrep '\(?[0-9]{3}[ )-]?[0-9]{3}[ -]?[0-9]{4}' $1

# get 10 digit, excluding over 11 digi
 cat $1 |tr '"', '\n'| egrep '\(?[0-9]{3}[ )-]?[0-9]{3}[ -]?[0-9]{4}' | egrep -v '\(?[0-9]{3}[ )-]?[0-9]{3}[ -]?[0-9]{5}' | uniq  
