#CVS Server

#CVS is a version control system. You can use it to record the history of source files.
#Installation

#At a terminal prompt, enter the following command to install cvs:

sudo apt-get install -y cvs

echo "#After you install cvs, you should install xinetd to start/stop the cvs server. At the prompt, enter the following command to install xinetd:"

echo "will do sudo apt-get install -y xinetd"
read read_line
sudo apt-get install -y xinetd
#export CVS_ROOT=
#Configuration

echo "Once you install cvs, the repository will be automatically initialized. By default, the repository resides under the /var/lib/cvs directory. You can change this path by running following command:cvs -d /your/new/cvs/repo init"

read read_line
sudo cvs -d /srv/cvs init

echo "Once the initial repository is set up, you can configure xinetd to start the CVS server. You can copy the following lines to the /etc/xinetd/cvspserver file.
"
ls /etc/xinetd/cvspserver
echo "^c to break, press any key to append below lines \"service cvsserver{port=2401...\" to /etc/xinetd/cvspserver" 
read read_line 
sudo echo "
service cvspserver
{
     port = 2401
     socket_type = stream
     protocol = tcp
     user = root
     wait = no
     type = UNLISTED
     server = /usr/bin/cvs
     server_args = -f --allow-root /var/lib/cvs pserver
     disable = no
}
" >  /etc/xinetd/cvspserver

echo "
[Note] 	

Be sure to edit the repository if you have changed the default repository (/var/lib/cvs) directory.

Once you have configured xinetd you can start the cvs server by running following command:"
echo "will do:sudo /etc/init.d/xinetd start"
sudo /etc/init.d/xinetd start

echo "You can confirm that the CVS server is running by issuing the following command:

sudo netstat -tap | grep cvs"
sudo netstat -tap | grep cvs


echo "When you run this command, you should see the following line or something similar:

tcp        0      0 *:cvspserver            *:* LISTEN 

From here you can continue to add users, add new projects, and manage the CVS server.
[Warning] 	

CVS allows the user to add users independently of the underlying OS installation. Probably the easiest way is to use the Linux Users for CVS, although it has potential security issues. Please refer to the CVS manual for details.
Add Projects"
read read_line

echo "This section explains how to add new project to the CVS repository. Create the directory and add necessary document and source files to the directory. Now, run the following command to add this project to CVS repository:

cd your/project
cvs import -d :pserver:username@hostname.com:/var/lib/cvs -m "Importing my project to CVS repository" . new_project start
"
read read_line

echo "[Tip] 	

You can use the CVSROOT environment variable to store the CVS root directory. Once you export the CVSROOT environment variable, you can avoid using -d option to above cvs command.

The string new_project is a vendor tag, and start is a release tag. They serve no purpose in this context, but since CVS requires them, they must be present.
[Warning] 	

When you add a new project, the CVS user you use must have write access to the CVS repository (/var/lib/cvs). By default, the src group has write access to the CVS repository. So, you can add the user to this group, and he can then add and manage projects in the CVS repository. 
"
echo "CVS_ROOT=$CVS_ROOT"

