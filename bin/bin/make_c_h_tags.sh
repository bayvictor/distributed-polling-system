find|grep -e "\.[ch]$"|xargs etags -a 
find|grep -e "Makefile"|xargs etags -a
find|grep -e "\.mk$"|xargs etags -a
find|grep -e "\.mak$"|xargs etags -a

