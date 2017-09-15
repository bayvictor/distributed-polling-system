sudo apt-get install -y x11vnc
#install an X11VNC server to share your desktop with other computer: 

   sudo apt-get install -y x11vnc

#    * Run X11VNC without a password: 

x11vnc -forever -rfbport 5900

#    Note: -rfbport 5900 specifies the port to listen on. The port number can be changed. This option is not required if the default port 5900 will be used. Don't forget to open/forward this port in your firewall/router. By default X11VNC server exits after the first client disconnects. To keep it running (and allow future connections), use the -forever option. See here for more command line options. 

#    * Create a password to use with X11VNC: 

mkdir ~/.vnc
x11vnc -storepasswd YOUR_PASSWORD ~/.vnc/x11vnc.pass

#    * X11VNC can then be started with a password: 

x11vnc -forever -rfbport 5900 -rfbauth ~/.vnc/x11vnc.pass -o ~/.vnc/x11vnc.log -loopbg -display :0

#Using VNC with SSH

#See Port forwarding through SSH for additional information.
#Vinagre VNC client

#Vinagre is the default Gnome-based VNC client used in Ubuntu.

#    * Applications -> Internet -> Remote Desktop Viewer 

#Terminal Server Client

#The Terminal Server Client is an Ubuntu/Gnome frontend for rdesktop (for RDP connections to Windows computers) and one of several vncviewer clients (for VNC connections). In can be used instead of Vinagre.

#    * Applications -> Internet -> Terminal Server Client 

#    * To use it with VNC, one of the VNC clients must be installed first. For example, install the TightVNC client: 

sudo apt-get install -y xtightvncviewer

#        * Note that the TightVNC client can be used from the command line (or as a menu item) directly: 

vncviewer 192.168.0.12::5900

#    where 192.168.0.12 is an example host location that is running a VNC server on port 5900. For more command-line options, use 

man vncviewer

#Krdc VNC client

#Krdc is the default VNC client in Kubuntu/KDE. It can be used for both VNC and RDP connections.

#    * K-Menu -> Internet -> Krdc 

#    * The command-line connection (for use as a menu-item, for example) is: 

krdc vnc://<remote IP>

#    * If the remote (Krfp) VNC server is using a <remote port> other than the default 5900 port, use 

krdc vnc://<remote IP>:<remote port>

#    * Krdc can also connect to a Windows server using RDP (Remote Desktop Protocol). 

krdc rdp://<remote IP>:<remote port>

#Using a VNC client with SSH 
