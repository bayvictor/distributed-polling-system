;; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.

echo "      #在当前项目仓库中配置访问该仓库的用户信息:"
git config --add user.name "zxk"
git config --add user.email "zxk@163.com"
git config --add user.name "bliss"
git config --add user.email "bliss@163.com"
git config --add user.name "dummy"
git config --add user.email "dummy@163.com"
echo "      这些信息被添加在当前项目仓库的.git/config文件的[user]段中了;

sudo useradd vhuang
sudo passwd vhuang      

      如果git config命令加上--global选项,那些这些用户信息就会被添加到~/.gitconfig文件的[user]段中;
      如:"
git config --global --add user.name "zhangsan"
git config --global  --add user.email "zhangsan@163.com"
      
echo "      如果git config命令加上--file选项,那些这些用户信息就会被添加到--file所指定的文件的[user]段中;
"

echo ":

STEP9:在客户端直接clone该仓库就可以了;
      git clone zxk@192.168.0.251:/repo/top1 test
      然后初始化第一个版本的数据并提交;


"