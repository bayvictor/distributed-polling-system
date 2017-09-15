echo "How I installed VMWare Server
First I brought up a text terminal by clicking Applications -> Accessories -> Terminal. All command lines are given on this terminal.

       1. Typed on command line:

echo input passwd in next line!
"
          echo "deb http://archive.canonical.com/ubuntu feisty-commercial main" | sudo tee -a /etc/apt/sources.list
read read_linei

echo"          (This command appends to file /etc/apt/sources.list the text /echoed. To avoid typing mistakes, select the line above with the mouse, move the mouse pointer (arrow) into the terminal area, click the mouse middle button and press the [Enter] key. Your user password will be required at this point. The echoing of the text on your terminal acknowledges that it was written in the file.)
       2. I registered (gratis) at http://register.vmware.com/content/registration.html and asked for a serial number, which appeared on the browser window. I selected that number with the mouse and typed on the terminal:
B
"
          cat > vmware-serial-number.txt
echo "
          pressed [Enter] key, clicked the middle button of the mouse, then typed [Enter][Ctrl-D]. That way I saved the serial number for later use in a text file.
       3. Typed line command:
"
          sudo apt-get update
echo "
       4. Typed line command:
I"
          sudo apt-get install -y vmware-server
read read_line
echo "
          Then apt-get downloaded about 85 MB of files. After installation, 143 MB of disk space was taken.
       5. In the installation process I was prompted to accept the EULA, which I did.
       6. The vmware-server installer then asked for the serial number that I had saved; on the already open terminal I typed
"
read read_line
          cat vmware-serial-number.txt
echo "
          which echoed the 20-character code on screen. I selected that number with the mouse and clicked the middle button in the prompt field. OK.
       7. When the installation ended, I went to Applications -> System, and found the vmware server square symbol at the bottom of the pulldown menu. Success!
       8. I clicked on that symbol, and I was greeted by the Connect to Host dialog box, where I clicked on the Connect button.
       9. The VMware Server Console popped up, waiting for orders.
      10. I then needed an installation disk, so I went to the Linspire site and downloaded the .iso file for the distribution into my /opt/downloads/ directory. 

On the VMWare Server Console under Ubuntu 7, I clicked on button Create New Virtual Machine, and answered its questions, as follows:

        *
        * Clicked Next on the New Virtual Machine Wizard welcome window
        *
        * Chose Typical
        *
        * Then, I chose the Guest Operating System Linux with the version Other Linux 2.6.x kernel
        * Gave the name Freespire and the location browsed to /opt/vmware/Virtual-Machines/Freespire. Normally I would accept the path suggested by VMWare, but I had enough disk space on my /opt partition but not on the root (/) partition.
        *
        * I then chose the Network Type: chose Use bridged networking
        *
        * Disk size: chose 3.5 GB, kept Allocate all disk space now and deselected the Split into 2 GB files.
        *
        * Clicked on Finish, and the 3.5 GB space was set apart. Then I was back to the main window of the new virtual machine.
        *
        * Clicked on Edit virtual machine settings
        *
        * Memory: I adjusted to 512 MB, because I have 768 MB RAM on my computer.
        *
        * CDROM 1 -> Use ISO image; then I browsed for the .iso file I had downloaded. This is a nice facility, because I didn't have to burn a DVD for this purpose.
        *
        * Removed Floppy 1 because there is not one on my hardware.
        *
        * Added Sound Adapter
        *
        * Clicked on Power On (the green arrow). Notice the changes in the hardware. 

And the normal installation of the operating system started. Some distributions do not recognize the recommended SCSI disk drives, and require IDE type. In this case, it is necessary to edit the configuration, remove the disk drive, add a new virtual disk drive of the IDE type, and initiate installation again.
When you remove a virtual disk drive you have to manually delete the vm-name-flat.vmdk and vm-name.vmdk files in the path given by Configuration file or else you run out of disk space.
In some cases, it is necessary to do manual partitioning, due to the limited space we assign the virtual machine, just for testing; in such cases, it is better assign a small portion to memory swap and the remainder to the root directory, which is always acceptable by Linux.
Of course, it you have a real bootable installation CD, you must set the CDROM unit as hardware, insert your CD into the real CD drive, and hit the green arrow (Power on).
I tried to install Mandriva2007Spring, but it is unable to save the Grub loader onto the virtual MBR. I simply removed the virtual hard drive and now use the live CD (.iso) file each time. It seems that there is always a new trick we can quickly test under a virtualizer. It is really fun to play with it.
Virtualization at the workplace
Many professional workstations would benefit from the use of virtual Windows machines under GNU/Linux: those companies willing to migrate to open-source, but that still depend on a Windows-only application. By running that particular application under a virtual Windows machine, such companies can continue operation without change, while they train employees on GNU/Linux, as well as develop and test new, multiplatform applications capable to replace the existing Windows-only applications. This is an easy and inexpensive way to solve the same dilemma faced by many enterprises and government agencies nowadays; I really hope they find out soon.
Virtualization in the Home
At home, people always find some reason to postpone their migration to open source. By means of virtual machines, they can all migrate to GNU/Linux immediately, take their time until they are able to fully substitute the incompatible applications until they can drop the Windows virtual machine.
I have ten virtual machines installed under my VMWare: one is Windows XP, and the others are different distributions of GNU/Linux that I am testing out of curiosity. It happens that under a VM, it is much easier to download, install, test, uninstall OSs without having to reboot the physical computer. I would like to test Windows 98, but I still have to learn how to put together the appropriate .iso file from the non-bootable CD.
While it took me weeks to install and experiment with five or six operating systems last year by clumsily partitioning my 80 GB hard disk drive, I could experiment with a dozen OSs now in a few days after I installed VMWare on that same hd. The nice thing is that I don't need to burn a CD for each OS, I just need the .iso, which I will discard when I am done.

This article published by permission from Mario Miyojim.

Linux is a registered trademark of Linus Torvalds. IBM is the registered trademark of International Business Machines. Microsoft, Microsoft Windows are trademarks or registered trademarks of Microsoft Corporation both in the United States and Internationally. VMware is the registered trademark for VMware Inc. an EMC Company. All other trademarks or registered trademarks in this article belong to their respective owners.

i:"

