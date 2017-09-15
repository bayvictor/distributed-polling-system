#emacs /home/vhuang/bin/git_build_gitosis.sh
echo "domingo 7 de marzo de 2010
Install git server in Debian with gitosis
First install git :"

apt-get install -y git python-setuptools python-dev


echo "get gitosis :"

git clone git://eagain.net/gitosis.git
cd gitosis
python setup.py install


echo "To create a git user to own the repositories:"

sudo adduser --system --shell /bin/sh --gecos 'git version control' --group --disabled-password --home /home/git git




echo "This part is for secure access:
First generate the public key from the user of YOUR computer:"

ssh-keygen -t rsa



echo "then copy id_rsa.pub to the server (I copied it to /tmp)

Now add the pub key:"

sudo -H -u git gitosis-init < /tmp/id_rsa.pub



echo "It should show:

Initialized empty Git repository in /home/git/repositories/gitosis-admin.git/
Reinitialized existing Git repository in /home/git/repositories/gitosis-admin.git/


Now at you local computer, test git :


git clone git@YOUR_SERVER_HOSTNAME:gitosis-admin.git"
git clone git@127.0.0.1:gitosis-admin.git
cd gitosis-admin

echo "

Gitosis never works with passwords. It always uses SSH keys. You need to configure the use of whatever public key goes with the private key you gave it when you ran gitosis-init. You would do this by editing ~/.ssh/config to include a stanza like

Host githost # hostname you use on the commandline, in git remotes, etc.
HostName 12.34.56.78 # actually IP address or DNS name to connect to
User gitosis
IdentityFile ~/.ssh/id_rsa # whatever file stores the private key matching the public key you gave gitosis"


echo "You are done! with gitosis.conf you could manage the git repo!
en 09:16
Etiquetas: Deploying a Git Repository Server, git debian server, git server, gitosis configuration
1 comentarios:

Claudia Lawrence dijo...

    Hi, ur blog is really nice & informative, while reading it I truly like it. I just wanna suggest that u should submit your blog in this website which is offering very unique features at cheap prices there are expert advertising team who will not only provide the adspace but also promote ur blog & affiliate ads through all over the networks which will definitely boost ur traffic & readers. Finally I have bookmarked ur blog & also shared to my friends. hope u have a wonderful day & !!happy blogging!!.
    9 de marzo de 2010 03:43 

Publicar un comentario en la entrada

Entrada más reciente Entradas antiguas Página principal
Suscribirse a: Enviar comentarios (Atom)
Follow me

Entradas populares

    *
      WRT54GL v1.1 sd card mod with openwrt
      Here is the colors I used to connect the ssd card The blue cable, that goes with the pin of the DMZ led. The yellow,green an red cables...
    *
      Ubuntu 10.04 and Ogre3D tutorial
      Install Compiler,Configuration tools and Ogre Dependencies sudo apt-get install -y build-essential automake libtool cmake-gui cmake-qt-gui me...
    *
      How to install Mercurial on Debian (or Ubuntu)
      Download the lastest version of Mercurial , then install it running : tar -xzvf mercurial-1.5.tar.gz cd mercurial-1.5 make all sudo make...
    *
      How to install apache2 mod_security 2.5 (Debian)
      First install dependencies apt-get install -y libxml2-dev liblua5.1-0 lua5.1 apache2-threaded-dev now get the mod_security wget http://www.mods...
    *
      Squid + Clamav : scan for virus at your cache server
      First get c-icap , clamav and Squid 3.0 some possible dependencies (Debian) : apt-get install -y build-essentials gcc g++ libcap1 libcap2 In...
    *
      Install Monaco font Ubuntu (or Debian)
      sudo mkdir /usr/share/fonts/truetype/custom sudo mv Monaco_Linux.ttf /usr/share/fonts/truetype/custom/ sudo fc-cache -f -v Download ...
    *
      Direct PCB Printing with a Laser Printer
      [Mark Lerman] is developing a method to apply toner directly to the copper clad using a laser printer. Each of the photos in his gallery ...
    *
      WRT54GL v1.1 bricked revive
      When the router starts, linksys allows to recover the firmware with tftp. There is a problem, at de nvram the bootwait should be put to "ON"...
    *
      vnc4server boot script (working in Debian/Ubuntu/Kubuntu)
      Problem : At my debian/ubuntu/kubuntu installing vnc4server dont start at boot, so I had to log via ssh to sart it up. This post is to reso...
    *
      CruiseControl + Symfony = Continous Build
      I like continous builds and tests, they give some confidence when you are refactoring,etc. If you dont know cruisecontrol is is both a co...

	
	
Plantilla Awesome Inc.. Imágenes de plantillas de rajareddychadive. Con la tecnología de Blogger.
Google Analytics Alternative "

