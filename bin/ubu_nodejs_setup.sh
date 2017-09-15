	
sudo apt-get install -y nodejs
echo "Thn install the Node package manager, npm:

1"
sudo apt-get install npm
echo "Create a symbolic link for node, as many Node.js tools use this name to execute.

1"

sudo ln -s /usr/bin/nodejs /usr/bin/node
echo "Now we should have both the Node and npm commands working:

1
2
3
4
$node version: 
"
node -v
#v0.10.25
echo "npm version:"
npm -v
#1.3.10


