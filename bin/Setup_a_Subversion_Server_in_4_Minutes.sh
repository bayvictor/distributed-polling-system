sudo apt-get install -y libapache2-svn #- Subversion server modules for Apache


echo "Setup_a_Subversion_Server_in_4_Minutes    #s
Setup a Subversion Server in 4 Minutes
March 2nd, 2007 tony Leave a comment Go to comments
http://www.tonyspencer.com/2007/03/02/setup-a-subversion-server-in-4-minutes/"

read readline

echo "You are going to need to type fast but I think you can do it in 4 minutes. :) These are my notes on what worked for me on my Fedora core 6 with svn lib already installed by the package manager:
1. Create a Repository
"
sudo apt-get install -y subversion #- Advanced version control system

svnadmin create /svnrepos

echo "2. Create a SVN User


open new terminal doing:
vi /svnrepos/conf/svnserve.conf

In that file add these three lines:

anon-access = none
auth-access = write
password-db = passwd

Create a password file:

vi /svnrepos/conf/passwd

In that file add a line for your user:

# add users in the format : user = password
vhuang = hhq202 

"
vi /svnrepos/conf/svnserve.conf
vi /svnrepos/conf/passwd

read readline

echo "3. Import Your Project

(assuming you’ve put your project files in /projects/myrailsproject)

svn import /projects/myrailsproject file:///svnrepos/myrailsproject

4. Start the SVN Server as Daemon
"

read readline

svnserve -d

echo "Done! You should now have a svn server running with one project named myrailsproject.

Try checking it out of the repository:
svn co svn://192.168.0.2/svnrepos/myyrailsproject
"
svn co svn://127.0.0.1/svnrepos/myyrailsproject


echo "Since we set anon-access to none you should be prompted for username and password which you created in the file /svnrepos/conf/passwd.
Categories: Code, Linux Tags:
Comments (30) Trackbacks (1) Leave a comment Trackback

    Ganeshji Marwaha
    March 3rd, 2007 at 00:04 | #1
    Reply | Quote

    Very simple yet effective tutorial. Thanks for sharing.
    Ubersoldat
    March 3rd, 2007 at 09:11 | #2
    Reply | Quote

    That’s It??? Well, I think I can do it faster than 4 minutes, let’s try… …

    jejeje… see? It was faster, installation included (with Ubuntu)

    Total Time: 2:30 now, I don’t know if this works :)
    Florin
    March 12th, 2007 at 06:17 | #3
    Reply | Quote

    problem with import?
"
read readline

echo 
    "svn: error while loading shared libraries: /usr/local/lib/libsvn_ra_dav-1.so.0: cannot restore segment prot after reloc: Permission denied”

    any ideea ? PLS PLS HELP me achebv@gmail.com
"



