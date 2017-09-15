echo "Install with Command Line

Adding the ppa
:"
sudo add-apt-repository ppa:ubuntu-audio-dev/ppa
sudo apt-get update

echo "Install the linux-alsa-driver-modules package
:"
sudo apt-get install linux-alsa-driver-modules-$(uname -r)

echo "Note: After installing the linux-alsa-driver-modules package, your system needs to be rebooted.
"

