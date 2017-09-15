
sudo dpkg --add-architecture i386

echo "Since Ubuntu 10.04 (Lucid Lynx), Skype is part of the Canonical partner repository. To install Skype add the Canonical Partner Repository. You can do this by running the command
"

sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"

echo "Thn install Skype via the Software-Center or via the Terminal.
"
sudo apt-get update && sudo apt-get install skype


