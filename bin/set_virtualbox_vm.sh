echo "At the top, there are two settings which you may want to change if you use the script. The VBOX= setting contains the full path to VBoxManage, VirtualBox's command line tool. SCRIPT_EXT= is the extensions for the generated scripts.
"

VBOX="/usr/bin/VBoxManage"
SCRIPT_EXT="command"

echo "Next, there are defaults for the VMs parameters in case the user enters no value.
"

RAM="512"
DISK_SIZE="8196"
DISK_TYPE="vdi"

echo "The script asks for the parameters and uses the defaults if no value is entered. For example, the question for the disk size:
"

echo -n "Enter disk size in MiB [${DISK_SIZE}]: "
read a
DISK_SIZE=${a:-${DISK_SIZE}}

echo "The main part. The base directory, the VM and the disk image are created. The VM is configured according to the parameters above.
"

mkdir -p "${VM_DIR}"
 
${VBOX} -q createvm --name "${VM_NAME}" --basefolder "${BASE_DIR}"
${VBOX} -q registervm "${VM_DIR}/${VM_NAME}.xml"
${VBOX} -q storagectl "${VM_NAME}" --name "IDE Controller" --add ide
${VBOX} -q createhd --filename "${VM_DIR}/${VM_NAME}.vmdk" --size "${DISK_SIZE}" --format VMDK
${VBOX} -q modifyvm "${VM_NAME}" --hda "${VM_DIR}/${VM_NAME}.vmdk"
${VBOX} -q storageattach "${VM_NAME}" --storagectl "IDE Controller" --port 0 --device 1 --type dvddrive --medium emptydrive
 
test ! -z "${RAM}" && ${VBOX} -q modifyvm "${VM_NAME}" --memory "${RAM}"

echo "Finally, the scripts are created. There are three of them: activate, boot (same as activate, just with an additional boot command) and deactivate. The variables are evaluated while creating, so the following code will create the activation script below.

Code:
"

cat << __SCRIPT__ > "${VM_DIR}/activate.${SCRIPT_EXT}"
#! /bin/sh
 
${VBOX} -q registervm "${VM_DIR}/${VM_NAME}.xml"
${VBOX} -q modifyvm "${VM_NAME}" --hda "${VM_DIR}/${VM_NAME}.vmdk"
${VBOX} -q storageattach "${VM_NAME}" --storagectl "IDE Controller" --port 0 --device 1 --type dvddrive --medium emptydrive
__SCRIPT__

Result:

#! /bin/sh
 
/usr/bin/VBoxManage registervm "/local/temp-vm/temp-vm.xml"
/usr/bin/VBoxManage modifyvm "temp-vm" --hda "/local/temp-vm/temp-vm.vmdk"
/usr/bin/VBoxManage -q storageattach "temp-vm" --storagectl "IDE Controller" --port 0 --device 1 --type dvddrive --medium emptydrive

echo "You can have a look at the code either in the version as of this article or in the latest version. Please keep in mind that not all written here may be true for the later as the script will be improved in the future.
The Future

There are some things, which not yet work as I want them to.

    The VM must not have snapshots.
    You have to shut down the VM. If you suspend it, it won't detach.
    As the DVD drive is removed and recreated, the VM won't remember the mounted image.

If you found this script useful, please let me know (you can use the contact form or leave a comment). You can also subscribe the further blog postings of follow the changes to my scripts collection on bitbucket.org.
"
