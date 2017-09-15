echo "below shell is from:  http://strdoc.com/comment/417"
echo "Submitted by str on Sat, 06/23/2007 - 12:30am
I was kinda surprise that HyperTerminal is not available anymore in Windows Vista. No problem, I rebooted my notebook to Ubuntu and fire-up minicom.

   1. By default, minicom is not installed in Ubuntu, so you need to install it first.
"     
echo "Press anykey to install minicom in ubuntu, ^C to break..."
read readline
sudo apt-get install minicom
   
echo"   2. Find the name of your Serial Port
"

echo "Press anykey to install minicom in ubuntu, ^C to break..."
read readline

dmesg | grep tty
echo "      
 In the output look for something like \"tty\". The output in my case is like this:
dmesg | grep tty
      [ 17.341823] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
      [ 17.342454] 00:0b: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
      This means the device correspond to my serial port is ttyS0.
"  
   
   
echo "   3. Configure minicom
"

echo "Press anykey to install minicom in ubuntu, ^C to break..."
read readline
sudo minicom -s
          
          
echo "          * Use the keyboard keys to select the menu item Serial port setup.
          * Enter A to change the Serial Device to /dev/ttyS0, and then enter E to change the line speed to 9600 8N1
          * Using arrow keys, select Save setup as dfl
   4. Select Exit from Minicom.
"   
   
echo "Press anykey to install minicom in ubuntu, ^C to break..."
read readline
   
echo "5. Next time, from the terminal you only need to run sudo minicom in order to access your Cisco box. 

Q.How can I use the serial port on the Dragonboard?
Published 01/03/2012 06:12 PM   |    Updated 03/20/2012 11:15 AM   |    Access Level Everyone   |    Answer ID 1096
How can I use the serial port on the Dragonboard?
A. You can connect to the serial port with a straight-thru (not a null modem) serial cable.  Set your terminal program to use 115200,8,n,1,Xon/Xoff.  This will give you access to a command prompt similar to using \"adb shell\" over the USB connection.
Was this answer helpful?

"
