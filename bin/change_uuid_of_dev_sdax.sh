#uuidgen | xargs tune2fs /dev/sda9  -U ; vol_id /dev/sda9 
uuidgen | xargs tune2fs $1   -U ; vol_id $1 
 
