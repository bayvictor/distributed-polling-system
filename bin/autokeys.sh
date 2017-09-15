echo "Create a .ssh Directory

Change to the home directory
i"
mkdir ~/.ssh
cd ~/
echo "
Create a SSH directory name .ssh and move into it
"
mkdir .ssh ; cd .ssh
echo "
Make sure that the file permissions are set to read/write/execute only for the user
"
chmod go-rwx .ssh
echo "
Create your private and public key, the blank quotes at the end of the command gives the private key no password, so allowing for passwordless logins!
"
ssh-keygen -y -b 1024 -t rsa -f id_rsa -P ""


