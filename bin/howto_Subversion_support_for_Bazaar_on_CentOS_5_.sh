echo "
 adapt from the code 4 years ago!



































Subversion support for Bazaar on CentOS 5
    Added by David Strauss (old), last edited by David Strauss (old) on Mar 29, 2010  (view change)
    show comment

   Install Bazaar and other stuff:
"
    sudo yum install bzr bzrtools zlib-devel httpd-devel subversion-devel sqlite-devel bzip2-devel \
    openssl-devel
echo 
""
   which python
    python --version

echo "    Install bzr-svn:
requiring updating to the the latest stable version, victor!
i"
echo "^C to break, any other key to continue..."; read readline


    mkdir -p ~/.bazaar/plugins
    cd ~/.bazaar/plugins
    wget http://launchpad.net/bzr-svn/1.0/1.0.2/+download/bzr-svn-1.0.2.tar.gz
    tar xzf bzr-svn-*.tar.gz
    rm bzr-svn-*.tar.gz
    mv bzr-svn-* svn

    Ignore non-compiled extensions:

    echo "ignore_missing_extensions=True" >> ~/.bazaar/bazaar.conf

 echo "   Check the Bazaar version (expect to see it using Python 2.6.x):
"
    python /usr/bin/bzr --version

 echo "   Check the plugin status (expect to see svn):
"
    python /usr/bin/bzr plugins

echo "    Install subvertpy (0.7.2 does not seem to build properly):
"
    cd
    wget http://samba.org/~jelmer/subvertpy/subvertpy-0.7.1.tar.gz
    tar xzf subvertpy-*.tar.gz
    rm subvertpy-*.tar.gz
    cd subvertpy-*
    python setup.py install --prefix=~/python26

 echo "   Test on a public repository:
"
    cd
    python /usr/bin/bzr branch -r1 svn+https://svn.mcs.anl.gov/repos/bcfg/trunk/bcfg2

    Clean up

    rm -rf ~/Python-2.6.*
    rm -rf ~/subvertpy-0.*

echo " v   No labels
    Edit Labels

User icon: Anonymous
Write a comment…

Powered by Atlassian | Terms of Use | Answers


https://fourkitchens.atlassian.net/wiki/display/TECH/Subversion+support+for+Bazaar+on+CentOS+5

"


