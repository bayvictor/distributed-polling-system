echo "usage:$0 <cmd>"

man $1  | sed -e "s|.\x8||g" 

