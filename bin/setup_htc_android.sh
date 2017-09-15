echo "
Code:
"
sudo gedit /etc/udev/rules.d/99-android.rules

echo "after doing below copy-paste-save, reboot your computer...!
"

echo "^C to break, any key to continue...";read readline

echo " copy below into above file and save:

SUBSYSTEM==\"usb\", ATTRS{idVendor}==\"0bb4\", ATTRS{idProduct}==\"0cec\", MODE=\"0666\"
SUBSYSTEMS==\"usb\", ATTRS{idVendor}==\"0bb4\", ATTRS{idProduct}==\"0cec\"
TEST==\"/var/run/ConsoleKit/database\", \
RUN+=\"udev-acl --action=$env{ACTION} --device=$env{DEVNAME}\"
"
echo '
SUBSYSTEM=="usb", ATTRS{idVendor}=="0bb4", ATTRS{idProduct}=="0cec", MODE="0666"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0bb4", ATTRS{idProduct}=="0cec"
TEST=="/var/run/ConsoleKit/database", \
RUN+="udev-acl --action=$env{ACTION} --device=$env{DEVNAME}"


'
