# patch for errors for ubuntu9.10
#rm -fr vmware-server-distrib/

cd ~/bin
mkdir vmware.setup
cd vmware.setup

wget http://codebin.cotescu.com/vmware/vmware-server-2.0.x-kernel-2.6.31-14-install.sh
wget http://codebin.cotescu.com/vmware/vmware-server-2.0.x-kernel-2.6.3x-install.sh
tar -zxvf *-kernel*

cd raducotescu-vmware-server-linux-2.6.3x-kernel-f271f27
chmod +x *.sh
./vmware-server-2.0.x-kernel-2.6.3x-install.sh ~/bin/vmware.setup

# remote port used: 902 8222 8333 


#Please specify a port for remote connections to use [902] 

#Please specify a port for standard http connections to use [8222] 

#Please specify a port for secure http (https) connections to use [8333] 
