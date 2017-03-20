#ls *.rar |grep -e "\.rar$"|sed 's/^/unrar x \"/g;s/$/\"/g'
echo "unrar OS, waiting ..."
unrar x "./MacOSX1055-VMWARE.rar"
unrar x "./vhuang__Downloads__VMware_OS_X_10.4.7__OSX.rar"
unrar x "./Windows 98 SE VMWare 7.1 Image.rar"


#find  |grep -e "01\.rar$"|sed 's/^/unrar x \"/g;s/$/\"/g'
echo " unrar the first file, and the following 02.rar, etc will auto-link in!"
unrar x "./VMWare Image/Mac OS X Leopard_part001.rar"
unrar x "./Windows 7 x64 VMware Image/Windows 7 x64 VMware Image.part01.rar"
unrar x "./Windows XP Pro VMware Image/Win.XP.Pro.VMW.Image.part01.rar"


#find ~/Downloads |grep -e "01\.rar$"|sed 's/^/unrar x \"/g;s/$/\"/g' >>  ~/bin/unrar_all.sh

echo "unrar api software rather than OS image ...."
mkdir ../handbooks
cd ../handbooks
unrar x "/home/vhuang/Downloads/__math_discrete_graph_mathlab_mathematica/ESRI.ArcGIS.9.3 Arc Info/ArcGIS.9.3.SLX.part01.rar"
unrar x "/home/vhuang/Downloads/510 Electrical Engineering e-Books/Wiley._20-_20.Digital.Image.Processing.WK.Pratt.-.Third.Edition.2001.rar"
unrar x "/home/vhuang/Downloads/_handbooks_n_printouts/2008HANDBOOK/ARRL.2008.Handbook-iNFL.part01.rar"


