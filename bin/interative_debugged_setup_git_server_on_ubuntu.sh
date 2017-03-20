source  ~/bin/generating_ssh_public_private_keys.sh

echo "Installing a git server using gitosis

I¡¯m switching all my personal projects to git from Subversion. After watching the Peepcode git screencast, Subversion feels oh-so-2002 and I can¡¯t wait to bury it forever.

First we have to get git running on my Ubuntu server. I tried

sudo apt-get install git-core #do not do this!"

echo "but that led to trouble down the line. Better to just fetch the source and build from that:"

sudo apt-get install -y libexpat1-dev zlibc curl gettext openssl
cd ~/src
echo "press anykey to wget git-1.7...."
read readline
cd ~/src

wget http://ftp.devil-linux.org/pub/devel/sources/1.4/git-1.7.0.tar.bz2
tar -jxvf git-1.7.0.tar.bz2


#wget http://www.kernel.org/pub/software/scm/git/git-1.5.4.rc2.tar.gz
wget http://www.kernel.org/pub/software/scm/git/git-1.7.0.tar.bz2  #commented out after downloading ok!

echo "press anykey to make install git-1.7...."
read readline

tar -jxvf git-1.7.0.tar.bz2
cd git-1.7.0
sudo chown vhuang /usr/local
./configure
make prefix=/usr/local all
sudo make prefix=/usr/local install

echo "Then, following the excellent instructions on scie.nti.st, we grab the gitosis code: by git clone"
read readline
cd ~/src
git clone git://eagain.net/gitosis.git

echo "Then: install python-setuptools"
read readline

cd gitosis
sudo apt-get install python-setuptools
python setup.py install

echo "Next we have to create a git user to own the repositories:"

sudo adduser \
    --system \
    --shell /bin/sh \
    --gecos 'git version control' \
    --group \
    --disabled-password \
    --home /home/git \
    git
read read_line
echo "We copy my public ssh key into /tmp/id_rsa.pub, then run"
read read_line
sudo -H -u git gitosis-init < /tmp/id_rsa.pub
sudo chmod 755 /home/git/repositories/gitosis-admin.git/hooks/post-update

echo "And that¡¯s the end of the server-side setup! On the local machine, we check out the files that are needed to control the server. First we have to account for the fact that I run SSH on a nonstandard port: edit ~/.ssh/config and put this inside:

Host www.example.com
    Port 32767

Then you can do:

git clone git@YOUR_SERVER_HOSTNAME:gitosis-admin.git
cd gitosis-admin

This is the directory where you administer gitosis."

echo "As the commiter user (in my case rdn), commit and push the newly-created project.

rdn:~ cd /home/rdn/projects/idea-generator
rdn:~ git init
rdn:~ git remote add main_project git@Frankenstein:/home/git/repositories/idea-generator.git
rdn:~ git add .
rdn:~ git commit -a -m "initial project creation"
rdn:~ git push main_project master:refs/heads/master
"
echo "Update

The only way I was able to \'fix\' this was to log into the remote server and create the remote repository as follows:

As the git user in the gitosis repository location create a remote bare project:

git:~ "
cd /home/git/repositories
#git:~ 
mkdir idea-generator.git
#git:~ 
cd gitosis-admin.git
#git:~ 
git --bare init

echo "As the commiter user (in my case rdn), commit and push the newly-created project.

rdn:~ cd /home/rdn/projects/idea-generator
rdn:~ git init
rdn:~ git remote add main_project git@Frankenstein:/home/git/repositories/idea-generator.git
rdn:~ git add .
rdn:~ git commit -a -m "initial project creation"
rdn:~ git push main_project master:refs/heads/master

"


