echo "

Automatic Method:- This method is depends on cron job (Scheduler).

You can set the automatic method using cron job. By default crontabs rpm is installed in Linux server.

STEP 1:- Check crond service is running in server or not? If it is not, start it.

[root@localhost ~]# service crond status

crond (pid 1416) is running...

[root@localhost ~]# service crond start

Starting crond: [ OK ]

STEP 2:- Then set the scheduler on desire time. Edit the crontab and put the script in it and save the same.

[root@localhost ~]# crontab -e

55 23 * * * mysqldump --opt --user=admin --password='xyzabc123' databasename | gzip > /root/mysqlbackup/databasename.sql.gz
As per above example backup of database will automatically start on 23:55:00 and store it in /root/mysqlbackup/ directory (Folder).

STEP 3:- Run the below command and check the cron job list.
[root@localhost ~]# crontab -l
55 23 * * * mysqldump --opt --user=admin --password='xyzabc123' databasename | gzip > /root/mysqlbackup/databasename.sql.gz

That's it...
"

echo "^c to break,anykey to conitnue....";read readline

echo "restore:...............

 how to restore mysql database backup.
Restore the mysql database backup by using below command.
[root@LITESPEED ~]# mysql -u admin -p databasename < databasebackupfile.sql
Enter password:

After the run above command enter the mysql password.

Where
-u = user
admin = user name
-p = password 

"

echo "^c to break,anykey to conitnue....";read readline

