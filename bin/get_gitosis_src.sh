GITSERVER_IP="192.168.11.152"
echo "GITSERVER_IP=\"${GITSERVER_IP}\", are you sure it's exactly where to host github?"
echo "^C to break, anykey to continue..."

echo "

#git clone git://eagain.net/gitosis.git ~/src/gitosis
#above line always timeout or \"connection error\"
i
"
#cd ~/src

#git clone https://github.com/res0nat0r/gitosis.git


echo "source from 
http://bdxnote.blog.163.com/blog/static/844423520124137333373/

t账号用于管理git服务器:
useradd -s /bin/bash -d /home/git -G root -m -c \"Manager for git server\" -p git git
   "
useradd -s /bin/bash -d /home/git -G root -m -c "Manager for git server" -p git git




echo "
   其中,-p:指定账户git的密码;
   其中,-p:指定账户git的密码;
        -m:强制创建git账户的home目录;
        -d:指定git账号的home目录;
        -s:指定git账号的登录shell;
        -G:指定git账户所属的用户组;
        -c:指定git账号的描述;


2、升级系统:
"

echo  "^C to break, any other key to proceed..."
read readline



   sudo apt-get update
   sudo apt-get upgrade


echo  "^C to break, any other key to proceed..."
read readline


echo "
3、安装git相关的组件:
sudo apt-get install git-core openssh-server openssh-client
"

sudo apt-get install git-core openssh-server openssh-client
echo "4、安装gitosis
STEP1:初始化一下git服务器所管理的账户(提交代码时的账号);
      git@vhuang:~$ 
"
git config --global user.name "vhuang"
#      git@vhuang:~$ 
git config --global user.email "vhuang@analogixsemi.com"


echo  "^C to break, any other key to proceed..."
read readline



echo "STEP2:安装python的setup tool,为安装gitosis做准备;
      git@vhuang:~$ 
"
sudo apt-get install python-setuptools

echo " STEP3:获取gitosis安装包;
      git@vhuang:~$ 
"
mkdir ~/src_gitosis
 #     git@vhuang:~$ 

cd ~/src_gitosis/
#      git@vhuang:~/src_gitosis$ 
git clone git://eagain.net/gitosis.git
echo "      如果这个不行:
      Cloning into 'gitosis'...
      fatal: unable to connect to eagain.net:
      eagain.net[0: 208.78.102.120]: errno=Connection refused
      则可从如下位置clone gitosis包:
git clone https://github.com/res0nat0r/gitosis.git
"

echo  "^C to break, any other key to proceed..."
read readline


git clone https://github.com/res0nat0r/gitosis.git
echo "      Cloning into 'gitosis'...
      remote: Counting objects: 727, done.
      remote: Compressing objects: 100% (216/216), done.
      remote: Total 727 (delta 510), reused 701 (delta 495)
      Receiving objects: 100% (727/727), 111.73 KiB | 44 KiB/s, done.
      Resolving deltas: 100% (510/510), done.

STEP4:安装gitosis包;
      git@vhuang:~/src_gitosis$ 
A
A
#
"
cd gitosis/
#      git@vhuang:~/src_gitosis/gitosis$ 
sudo python setup.py install

echo "STEP5:生成ssh公钥,并上传到git服务器上,或直接使用git账户在git服务器上生成;现在采用使用git账户直接在git服务器上生成;
      git@vhuang:~$ "

ssh-keygen -t rsa
echo "      Generating public/private rsa key pair.
      Enter file in which to save the key (/home/git/.ssh/id_rsa):
      Created directory '/home/git/.ssh'.
      Enter passphrase (empty for no passphrase):
      Enter same passphrase again:
      Your identification has been saved in /home/git/.ssh/id_rsa.
      Your public key has been saved in /home/git/.ssh/id_rsa.pub.
      The key fingerprint is:
      34:34:76:a3:72:3f:05:46:d3:e1:72:62:68:e6:fa:63 git@vhuang
      The key's randomart image is:
      +--[ RSA 2048]----+
      |        +.B...   |
      |       o * =.    |
      |      . O + +    |
      |       B + =     |
      |        S o      |
      |       .   .     |
      |      .          |
      |       .E        |
      |       ...       |
      +-----------------+

STEP6:初始化gitosis;
      git@vhuang:~$ "


echo  "^C to break, any other key to proceed..."
read readline



sudo -H -u git gitosis-init < ~/.ssh/id_rsa
read readline
echo "      Initialized empty Git repository in /home/git/repositories/gitosis-admin.git/
      Reinitialized existing Git repository in /home/git/repositories/gitosis-admin.git/
      gitosid默认会会把git仓库放在git账号的home目录下;
      gitosis的有趣之处在于,它通过一个git仓库来管理配置文件,仓库就放在了/home/git/repositories/gitosis-admin.git;我们需要为一个文件加上可执行权限:
      git@vhuang:~$ 
pwd
      /home/git
      git@vhuang:~$ "
read readline

cd /home/git

chmod 755 repositories/gitosis-admin.git/hooks/post-update
read readline
echo "STEP7:配置gitosis,以控制git客户端的操作;
      git@vhuang:~$ "

git clone git@${GITSERVER_IP}:repositories/gitosis-admin.git

read readline
echo "      
cp below contents into gitosis.conf!!!!!!!!!!!!!

git@vhuang:~$ cd gitosis-admin/
      git@vhuang:~/gitosis-admin$ vi gitosis.conf
      [gitosis]
      loglevel = DEBUG

      [group gitosis-admin]                 #gitosis-admin为git组名;
      witeable = gitosis-admin              #gitosis-admin为仓库名;
      members = git@vhuang root@vhuang vhuang@vhuang

      #下面两个group配置实现把仓库teamwork的只读权限分配给git组team;
      #同时,把仓库teamwork的可写权限分配给git组team_ro;
      [group team]                          #team为git组名;
      writable = teamwork                   #teamwork为仓库名;
      members = a@svr b

      [group team_ro]                       #team_ro为git组名;
      readonly = teamwork                   #teamwork为仓库名;跟上面的team组里面的仓库名teamwork是同一个仓库;
      members = lz

      #例子:
      [group top1]
      writable = /repo/top1
      member = git@vhuang vhuang@vhuang root@vhuang

      #gitosis的group配置语法:
      [group git组名]
      writable = 仓库名
      members = user1@server user2 ......

      [group git组名]
      readonly = 仓库名
      members = user1@server user2 ......

      git@vhuang:~/gitosis-admin$ "
read readline

vi gitosis.conf
echo "      git@vhuang:~/gitosis-admin$ "
git add -A
     # git@vhuang:~/gitosis-admin$ 

git commit -m "init gitosis-admin config gitosis.conf"
#      [master 2691646] 

init gitosis-admin config gitosis.conf
#dd      1 file changed, 4 insertions(+)

#      git@vhuang:~/gitosis-admin$ 

git push origin master
echo "      git@${GITSERVER_IP}'s password:
      Counting objects: 5, done.
      Delta compression using up to 2 threads.
      Compressing objects: 100% (3/3), done.
      Writing objects: 100% (3/3), 374 bytes, done.
      Total 3 (delta 0), reused 0 (delta 0)
      To git@${GITSERVER_IP}:repositories/gitosis-admin.git
      3970fa2..2691646  master -> master

STEP8:创建一个仓库的存储位置,并初始化;
      git@vhuang:~$ "

mkdir -p /repo/top1
echo "      git@vhuang:~$ "
cd /repo/top1/
#      git@vhuang:/repo/top1$ 
git init --bare
read readline


echo "      #在当前项目仓库中配置访问该仓库的用户信息:"
git config --add user.name "vhuang"        #Victor Huang
git config --add user.email "vhuang@analogixsemi.com"
git config --add user.name "gstewart"      #Greg Stewart
git config --add user.email "gstewart@analogixsemi.com"
git config --add user.name 'nzhu'          #Ning Zhu                                                                                
git config --add user.email 'nzhu@analogixsemi.com'           
git config --add user.name 'mbadii'        #Mehran Badii
git config --add user.email 'mbadii@analogixsemi.com'
git config --add user.name 'yxiao'         #Yong Xiao
git config --add user.email 'yxiao@analogixsemi.com'
git config --add user.name 'span'          #Sheng Pan
git config --add user.email 'span@analogixsemi.com'
git config --add user.name 'fwang'         #fei Wang
git config --add user.email 'fwang@analogixsemi.com'
git config --add user.name 'swang'         #Shaoliang Wang  
git config --add user.email 'swang@analogixsemi.com'
 

echo " empty frame to put in userid & email 

git config --add user.name ''
git config --add user.email '@analogixsemi.com'

echo "
read readline
echo "      这些信息被添加在当前项目仓库的.git/config文件的[user]段中了;
      
      如果git config命令加上--global选项,那些这些用户信息就会被添加到~/.gitconfig文件的[user]段中;
      如:


git config --global  --add user.name 'gstewart'
git config --global  --add user.email 'gstewart@analogixsemi.com'
"
read readline      
echo "      如果git config命令加上--file选项,那些这些用户信息就会被添加到--file所指定的文件的[user]段中;
"

echo ":
read readline
STEP9:在客户端直接clone该仓库就可以了;
      git clone vhuang@${GITSERVER_IP}:/repo/top1 test
      然后初始化第一个版本的数据并提交;


"
read readline

echo "git常见问题:
1、push时,报如下错误:
$ git push
Counting objects: 32, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (16/16), done.
Writing objects: 100% (19/19), 2.60 KiB, done.
Total 19 (delta 13), reused 0 (delta 0)
remote: error: refusing to update checked out branch: refs/heads/master
remote: error: By default, updating the current branch in a non-bare repository
remote: error: is denied, because it will make the index and work tree inconsistent
remote: error: with what you pushed, and will require 'git reset --hard' to match
remote: error: the work tree to HEAD.
remote: error:
remote: error: You can set 'receive.denyCurrentBranch' configuration variable to
remote: error: 'ignore' or 'warn' in the remote repository to allow pushing into
remote: error: its current branch; however, this is not recommended unless you
remote: error: arranged to update its work tree to match what you pushed in some
remote: error: other way.
remote: error:
remote: error: To squelch this message and still keep the default behaviour, set
remote: error: 'receive.denyCurrentBranch' configuration variable to 'refuse'.
To ssh://corei5:3149/opt/LuoYun.git
 ! [remote rejected] master -> master (branch is currently checked out)
error: failed to push some refs to 'ssh://此处省略多字/opt/LuoYun.git'
解决方法:
默认情况下,git是拒绝(禁止)push操作的,需要修改配置在git服务器端的对应git仓库的.git/config文件中增加如下配置段:
[receive]
      denyCurrentBranch = ignore

2、push时,如果报如下错误:
$ git push
Counting objects: 20, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (10/10), done.
Writing objects: 100% (12/12), 2.91 KiB, done.
Total 12 (delta 4), reused 0 (delta 0)
error: insufficient permission for adding an object to repository database ./objects <<<<错误信息

fatal: failed to write object
error: unpack failed: unpack-objects abnormal exit
To ssh://jianlee@corei5:3149/opt/LuoYun.git
 ! [remote rejected] master -> master (n/a (unpacker error))
error: failed to push some refs to 'ssh://jianlee@corei5:3149/opt/LuoYun.git'
这是因为git服务器端对应git仓库目录的访问权限问题,如果一定要多用户访问git仓库,可以设置一个gituser组,给它分配足够的权限即可:
# chgrp -R gituser /path/to/gitrepo
# chmod -R 'g+rwx' /path/to/gitrepo
或者直接执行如下命令赋予权限:
sudo chmod 777 /path/to/gitrepo -R
"
read iread
