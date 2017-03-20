find|grep -e "\.[h|c]"|xargs grep iostream.h|cut -d":" -f1|xargs etags -a
