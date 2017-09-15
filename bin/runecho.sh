cat $1|sed 's/^/echo \"/g;s/$/\";/g' >test01.txt 
paste test01.txt $1 > $1.echo.sh                                                                                                                      
                                                                                                            
#$1.echo.sh
chmod +x *.sh
vi $1.echo.sh
echo "^c to break, anyket to continue...";read readline

./$1.echo.sh

