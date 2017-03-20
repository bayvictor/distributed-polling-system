#sudo -s
#ln -s /sda5 /sdb1
cd ~/src
git clone git://eagain.net/gitosis.git

echo "Notice that gitosis is extremely light-weight. The clone takes a mere couple seconds. Less is more, and I like that a lot.

Next, install it like so:
"
sudo apt-get install -y python-setuptools

cd gitosis
sudo python setup.py install


sudo adduser \
    --system \
    --shell /bin/bash \
    --gecos 'git version control' \
    --group \
    --disabled-password \
    --home /home/git \
    git

ssh-keygen -t rsa


echo "The public key will be in $HOME/.ssh/id_rsa.pub. Copy this file to your server (the one running gitosis).
next we do: \"sudo -H -u git gitosis-init < /tmp/id_rsa.pub
\"
"
read readline
echo "copy from local rsa generated key to server..."
cp /home/vhuang/.ssh/id_rsa.pub /tmp/id_rsa.pub


sudo -H -u git gitosis-init < /tmp/id_rsa.pub

echo "/sdb1/home/git is the disk has a large space for repo"
#sudo ln -s /sdb1/home/git /home/git
sudo chmod 755 /home/git/repositories/gitosis-admin.git/hooks/post-update

#git clone git@YOUR_SERVER_HOSTNAME:gitosis-admin.git
git clone git@localhost:gitosis-admin.git

cd gitosis-admin

echo "
next we do: ls -l
You will now have a gitosis.conf file and keydir/ directory:

\"
"
read readline

ls -l


echo "
next we do: editing of gitosis.conf 
You will now have a gitosis.conf file and keydir/ directory:
[gitosis]                  

[group gitosis-admin]
writable = gitosis-admin
members = vhuang   <=== substitute your username here!         
\"

[group myteam]
members = vhuang
writable = free_monkey  ## free_monkey is the repo name
"
read readline

gedit gitosis.conf &


git commit -a -m "Allow vhuang write access to free_monkey"
git push

echo "
next we do: Now the user \"vhuang\" has access to write to the repo named \"free_monkey\", but we still haven\'t created a repo yet. What we will do is create a new repo locally, and then push it: 
\"
"
read readline


mkdir free_monkey
cd free_monkey
git init
#git remote add origin git@YOUR_SERVER_HOSTNAME:free_monkey.git
git remote add origin git@localhost:free_monkey.git

# do some work, git add and commit files

git push origin master:refs/heads/master

echo "With the final push, you're off to the races. The repository \"free_monkey\" has been created on the server (in /home/git/repositories) and you\'re ready to start using it like any ol' git repo. "

read read_line
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo " ^C,  below are adding users!"

echo "

The next natural thing:
 to do is to grant some lucky few commit access to the FreeMonkey project. This is a simple two step process.

First, gather their public SSH keys, which I'll call \"alice.pub\" and \"bob.pub\", and drop them into keydir/ of your local gitosis-admin repository. Second, edit gitosis.conf and add them to the \"members\" list."
echo "in outside term, copy *.pubs !!!"
read readline

cd gitosis-admin
mkdir keydir
cp ~/sunmoon.pub keydir/
cp ~/xiangqun.pub keydir/
cp ~/daniel.pub keydir/
cp ~/alice.pub keydir/
cp ~/bob.pub keydir/
git add keydir/alice.pub keydir/bob.pub keydir/sunmoon.pub keydir/xiangqun.pub keydir/daniel.pub 


echo "
Note that the key filename must have a \".pub\" extension.

gitosis.conf changes:

 [group myteam]
- members = jdoe
+ members = jdoe alice bob
  writable = free_monkey

Commit and push:"
read readline

git commit -a -m "Granted Alice and Bob commit rights to FreeMonkey"
git push
echo "
That\'s it. Alice and Bob can now clone the free_monkey repository like so:
"
git clone git@YOUR_SERVER_HOSTNAME:free_monkey.git

echo "Alice and Bob will also have commit rights.
Public access

If you are running a public project, you will have your users with commit rights, and then you'll have everyone else. How do we give everyone else read-only access without fiddling w/ SSH keys?

We just use git-daemon. This is independent of gitosis and it comes with git itself."
read  readline

sudo -u git git-daemon --base-path=/home/git/repositories/ --export-all

echo "This will make all the repositories you manage with gitosis read-only for the public. Someone can then clone FreeMonkey like so:
"
read readline
git clone git://YOUR_SERVER_HOSTNAME/free_monkey.git

echo "To export only some repositories and not others, you need to touch git-daemon-export-ok inside the root directory (e.g. /home/git/repositories/free_monkey.git) of each repo that you want public. Then remove \"--export-all\" from the git-daemon command above.
More tricks
"
read readline
echo "
gitosis.conf can be set to do some other neat tricks. Open example.conf in the gitosis source directory (where you originally cloned gitosis way at the top) to see a summary of all options. You can specify some repos to be read-only (opposite of writable), but yet not public. A group members list can include another group. And a few other tricks that I'll leave it to the reader to discover.
Caveats

If /home/git/.gitosis.conf on your server never seems to get updated to match your local copy (they should match), even though you are making changes and pushing, it could be that your post-update hook isn't executable. Older versions of setuptools can cause this. Be sure to fix that:
"
read readline

sudo chmod 755 /home/git/repositories/gitosis-admin.git/hooks/post-update

echo "If your Python goodies are in a non-standard location, you must additionally edit post-update and put an \"export PYTHONPATH=...\" line at the top. Failure to do so will give you a Python stack trace the first time you try to push changes within gitosis-admin.
"
read readline
echo "If you want to install gitosis in a non-standard location, I don\'t recommend it. It\'s an edge case that the author hasn\'t run up against until I bugged him to help me get it working.

For the brave, you need to edit whatever file on your system controls the default PATH for a non-login, non-interactive shell. On Ubuntu this is /etc/environment. Add the path to gitosis-serve to the PATH line. Also insert a line for PYTHONPATH and set it to your non-standard Python site-packages directory. As an example, this is my /etc/environment:
"
read readline
echo "
export PATH=\"/home/garry/sys/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/X11:/usr/games\"
export PYTHONPATH=/home/garry/sys/lib/python2.4/site-packages

Be sure to logout and log back in after you make these changes.

Don't use the gitosis-init line I have above for the standard install, instead use this slightly modified one:

sudo -H -u git env PATH=$PATH gitosis-init < /tmp/id_rsa.pub

Be sure to also set PYTHONPATH in your post-update hook as described above.

The *should* do it. I am purposefully terse with this non-standard setup as I think not many people will use it. HIt me up in #git on FreeNode if you need more info (my nick is up_the_irons).

Non-standard SSH port

If you run SSH on a non-standard port on your server, don't use the syntax \"git@myserver.com:1234:/foo/bar\", it won\'t work. Putting the port in the URL doesn't seem to make gitosis, or git, (not sure which) happy. Instead, put this in your ~/.ssh/config file:"
read readline
echo "
Host myserver.com
  Port 1234

Conclusion

Well, I hope you enjoyed this tutorial and that it makes your Git hosting life easier. This is public revision 10. Please let me know if you find mistakes, omissions, an easier way than what I described, etc...

Git it on...

(yeah, that was bad...) 
"


