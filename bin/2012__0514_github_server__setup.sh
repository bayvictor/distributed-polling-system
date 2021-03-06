
MYUSER="bsquare2"
#MYUSER="vhuang"
echo "MYUSER=${MYUSER}"

echo "^c to break, any key to continue...
"

read readline

echo "source from: http://tumblr.intranation.com/post/766290565/how-set-up-your-own-private-git-server-linux

How to set up your own private Git server on Linux

Update 2: as pointed out by Tim Huegdon, several comments on a Hacker News thread pointing here, and the excellent Pro Git book, Gitolite seems to be a better solution for multi-user hosted Git than Gitosis. I particularly like the branch–level permissions aspect, and what that means for business teams. I’ve left the original article intact.

Update: the ever–vigilant Mike West has pointed out that my instructions for permissions and git checkout were slightly askew. These errors have been rectified.

One of the things I’m attempting to achieve this year is simplifying my life somewhat. Given how much of my life revolves around technology, a large part of this will be consolidating the various services I consume (and often pay for). The mention of payment is important, as up until now I’ve been paying the awesome GitHub for their basic plan.

I don’t have many private repositories with them, and all of them are strictly private code (this blog; Amanda’s blog templates and styles; and some other bits) which don’t require collaborators. For this reason, paying money to GitHub (awesome though they may be) seemed wasteful.

So I decided to move all my private repositories to my own server. This is how I did it.
Set up the server
"
read readline
echo "These instructions were performed on a Debian 5 \“Lenny\” box, so assume them to be the same on Ubuntu. Substitute the package installation commands as required if you’re on an alternative distribution.

First, if you haven\’t done so already, add your public key to the server:
Do below on a new open terminal! 

ssh ${MYUSER}@server.com
mkdir .ssh
ssh-keygen -t rsa
#Generating public/private rsa key pair.

scp ~/.ssh/id_rsa.pub ${MYUSER}@server.com:.ssh/authorized_keys


^c to break, any key to continue...k
"
read readline


echo "Now we can SSH into our server and install Git:
copy paste below into the new terminal... 
ssh ${USER}@myserver.com
sudo apt-get update
sudo apt-get install git-core

…and that’s it.  !!!!.
"
read readline

echo "next, Adding a user
!!!"
read readline

echo If you intend to share these repositories with any collaborators, at this point you\’ll either:

    Want to install something like Gitosis (outside the scope of this article, but this is a good, if old, tutorial); or
    Add a \“shared\” Git user.

We’ll be following the latter option. So, add a Git user:
"
read readline

sudo adduser git

read readline

echo "Now you’ll need to add your public key to the Git user\’s authorized_keys:
sudo mkdir /home/git/.ssh
sudo cp ~/.ssh/authorized_keys /home/git/.ssh/
sudo chown -R git:git /home/git/.ssh
sudo chmod 700 !$
sudo chmod 600 /home/git/.ssh/*

Now you’ll be able to authenticate as the Git user via SSH. Test it out:

ssh git@myserver.com

"
read readline


echo  "Add your repositories

If you were to not share the repositories, and just wanted to access them for yourself (like I did, since I have no collaborators), you’d do the following as yourself. Otherwise, do it as the Git user we added above.

If using the Git user, log in as them:

login git


Now we can create our repositories:

mkdir myrepo.git
cd !$
git --bare init

"
read readline


echo "

The last steps creates an empty repository. We’re assuming you already have a local repository that you just want to push to a remote server.

Repeat that last step for each remote Git repository you want.

Log out of the server as the remaining operations will be completed on your local machine.
Configure your development machine

First, we add the remotes to your local machine. If you’ve already defined a remote named origin (for example, if you followed GitHub’s instructions), you’ll want to delete the remote first:

git remote rm origin

Now we can add our new remote:

git remote add origin git@server.com:myrepo.git
git push origin master

And that’s it. You’ll probably also want to make sure you add a default merge and remote:

git config branch.master.remote origin && git config branch.master.merge refs/heads/master

And that’s all. Now you can push/pull from origin as much as you like, and it’ll be stored remotely on your own myserver.com remote repository.
Bonus points: Make SSH more secure

This has been extensively covered by the excellent Slicehost tutorial, but just to recap:

Edit the SSH config:

sudo vi /etc/ssh/sshd_config

And change the following values:

Port 2207
...
PermitRootLogin no
...
AllowUsers ${MYUSER} git
...
PasswordAuthentication no

Where 2207 is a port of your choosing. Make sure to add this so your Git remote:

git remote add origin ssh://git@myserver.com:2207/~/myrepo.git
"

read readline

