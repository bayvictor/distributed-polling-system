git commit -a -m "created first repository"
git push
cd ..

rails new idea-generator
cd idea-generator
git init

cd /home/vhuang/src/cling


git remote add UpnpBrowser-101103 localhost:/home/git/repositories/idea-generator.git
git add .
git commit -a -m "initial project creation"

git push  UpnpBrowser-101103 master:refs/heads/master

