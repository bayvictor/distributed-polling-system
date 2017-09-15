cd $1
rm -fr .git
git init && git add -A 
#git status
git commit -am $1 
git remote add origin git@lab:$1.git
git push -u origin master
cd ..

