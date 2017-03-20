echo "

Here is a blog in which some guy talks about setting up a Bazaar server as they didn't want to publish their code (just like me): http://zeth.net/post/366/

Firstly, they made a new user for Bazaar (to keep everything nice and clean):

$ "
sudo useradd -m bzruser

echo "After the user was set up, they simply created a regular repository there:

$ "


sudo su bzruser
 mkdir -p /home/bzruser/repository/group/project/trunk
 cd /home/bzruser/repository/group/project/trunk
 bzr init

echo "When the repo is created, you simply start the server by using

$ "

bzr server --directory=/home/bzruser/repository

echo "Which starts listening to port 4155 (though it can be changed using --port option).

Of course, directory hierarchy is up to you, the admin, as well as stuff like making the server start on boot, but it's a different story. Bazaar server is up and running ;)
shareimprove this answer
"


