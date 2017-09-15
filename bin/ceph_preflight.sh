echo "
Advanced Package Tool (APT)

For Debian and Ubuntu distributions, perform the following steps:

    Add the release key:
B
"
    wget -q -O- 'https://download.ceph.com/keys/release.asc' | sudo apt-key add -

echo "    Add the Ceph packages to your repository. Replace {ceph-stable-release} with a stable Ceph release (e.g., hammer, jewel, etc.) For example:
"
    echo "deb http://download.ceph.com/debian-jewel/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/ceph.list

echo "    Update your repository and install ceph-deploy:
B
B
"
    sudo apt-get update -y && sudo apt-get install -y ceph-deploy
echo "
Note

You can also use the EU mirror eu.ceph.com for downloading your packages. Simply replace http://ceph.com/ by http://eu.ceph.com/
"
