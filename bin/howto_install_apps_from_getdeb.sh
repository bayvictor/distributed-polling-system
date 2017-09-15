echo "How to Install Apps from GetDeb

Use the following instructions:

    Install the getdeb package.

    Or configure the repository manually:

    Go to System-Administration-Software Sources, Third-Party Software tab, Add:
    deb http://archive.getdeb.net/ubuntu raring-getdeb apps

    Add the repository GPG key, open a terminal window and type:
"
    wget -q -O- http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -

echo "    Click the \"Install this now\" button below the screenshot of the desired application.

    If you are using Kubuntu please check bug 476853.

    If the application cannot be found, run this command and try again:
"
    sudo apt-get update

echo "hide this from showing in the future
"


