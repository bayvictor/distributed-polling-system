mysqldump -u root -pjing214 --all-databases --events | gzip > db-`hostname`-mysql_all-databases-alldb-`timestamp`.sql.gz 
