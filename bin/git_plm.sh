echo "You have an empty repository
To get started you will need to run these commands in your terminal.
New to Git? Learn the basic Git commands
Configure Git for the first time"
echo "will do:
git config --global user.name \"Xiangdong (Victor) Huang\"
git config --global user.email \"v2.huang@partner.samsung.com\"
"
echo "^C to break, any otherkey to continue...";read readline

git config --global user.name "Xiangdong (Victor) Huang"
git config --global user.email "v2.huang@partner.samsung.com"
echo "
Working with your repository
I just want to clone this repository
If you want to simply clone this empty repository then run this command in your terminal.
git clone https://v2.huang@stash.sisa.samsung.com:8443/scm/csil/stelvio_jenkins.git
"
echo "^C to break, any otherkey to continue...";read readline

git clone https://v2.huang@stash.sisa.samsung.com:8443/scm/csil/stelvio_jenkins.git
echo "
Case #1: My code is ready to be pushed! Make sure *.gradle all working and build OK!
If you already have code ready to be pushed to this repository then run this in your terminal.
cd existing-project
git init
git add --all
git commit -m "Initial Commit"
git remote add origin https://v2.huang@stash.sisa.samsung.com:8443/scm/csil/stelvio_jenkins.git
git push origin master
My code is already tracked by Git
If your code is already tracked by Git then set this repository as your "origin" to push to.
cd existing-project
git remote set-url origin https://v2.huang@stash.sisa.samsung.com:8443/scm/csil/stelvio_jenkins.git
git push origin master

Ready?  Press return below:

"
echo "^C to break, any otherkey to continue...";read readline

#cd existing-project
cd $1

git init
git add --all
git commit -m "Initial Commit"
git remote add origin https://v2.huang@stash.sisa.samsung.com:8443/scm/csil/stelvio_jenkins.git
git push origin master

echo "case: My code is already tracked by Git"

echo "^C to break, any otherkey to continue...";read readline

If your code is already tracked by Git then set this repository as your "origin" to push to.
cd existing-project
git remote set-url origin https://v2.huang@stash.sisa.samsung.com:8443/scm/csil/stelvio_jenkins.git
git push origin master


