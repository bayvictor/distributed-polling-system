#!/bin/bash -x

echo "$0 <comment to git-commit all>   <new_created_world_name>"
echo "be careful! \"$2\" project will be clean-up, double check it's not empty first!"
echo "^c to break, anykey to continue!"
read readline 

ssh git@lab
mkdir $2.git
cd $2.git

echo "^c to break, anykey to continue!"
read readline
git init --bare

########mkdir my_project.git
#cd my_project.git
#git init --bare
#git-update-server-info # If planning to serve via HTTP
#exit

echo "^c to break, anykey to continue!"
read readline

echo "any time use those to check in project..."
#t@example.com
#
read readline

git init && git add -A 

git status

echo "^c to break, anykey to continue!"
read readline


git commit -am $1 
git remote add origin git@lab:$2.git
git push -u origin master
git status
echo "^c to break, anykey to continue!"
read readline
 

