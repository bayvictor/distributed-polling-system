
printUsage()
{
     
  echo "usage: $1 <part_dev_id> <vdi_filename>"
  echo "e.g.: $1 /dev/sda1 myimage.vdi"
  echo "e.g.: ./vbox_part_to_vdi.sh /dev/sda11 ubu10.10_32bit " 
  echo ""
  echo "will do :\"dd if=/dev/sdb | VBoxManage convertfromraw --format VDI stdin myimage.vdi \"  "
  echo ""
  echo "^C to break, anykey to cisee the target vdi name"
  read readline
}

#parameter  handling
if [ $# -eq 0 ]; then
	echo "missing arguments !";echo	
	printUsage
	exit 0
fi
echo " "


mid=`norm.sh $1`
echo "mid=\"$mid\""
headfn=`hostname`_"from"__$mid"-`timestamp`.vdi"
outvdi_fn=$headfn

echo "generated target vdi filename headfn=\"$headfn\""
echo "^C to break, anykey to clone partition to vdi file!!!!"
read readline

#sudo dd if=$1 | VBoxManage convertfromraw --format VDI stdin  $outvdi_fn
#sudo dd if=$1 | VBoxManage convertfromraw --format VDI  $outvdi_fn
sudo VBoxManage clonehd  $1   $outvdi_fn  --format VDI 
#dd if=/dev/sdb | VBoxManage convertfromraw --format VDI stdin myimage.vdi

