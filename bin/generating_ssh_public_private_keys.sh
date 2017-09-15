sudo apt-get install openssh-server -y 
sudo apt-get install openssh-client -y


echo "Mind that if you leave the passphrase empty, anybody getting you private key (/home/user/.ssh/id_rsa) will be able to connect to your remote host.

I would recommend that you enter a passphrase, this passphrase will be use to \"unlock\" the key, mind that this passphrase is not related to the remote user password.

You can define another filename to save your keys to. This become handy when you have a different set of key pairs to different hosts

By now, you should have id_rsa and id_rsa.pub in ~/.ssh directory.
"
read readline
echo "
id_rsa is the so called private key. id_rsa.pub is the public key, the one you are going to upload on your server in order to be able to gain access to the remote machine using key authetication.

Do not share your private key, this key has to be your own, nobody but you will need to use it.
The need of a passphrase will save you a lot of trouble in case you lost it.

Now that we have our public/private key pair ready, we need to upload it to the remote machine and enable access with it.

"
echo "^C to break, anykey to ssh-keygen, see your id_rsa, id_rsa.pub in ~/.ssh!"
read readline


ssh-keygen
 
