sudo -s

deviceId=`xinput list|grep Pad|cut -d"=" -f2|cut -d"[" -f1`

echo "deviceId=$deviceId"
xinput set-prop $deviceId "Device Enabled" 0


gconftool --type bool --set /desktop/gnome/peripherals/touchpad/touchpad_enabled true

sudo add-apt-repository ppa:atareao/atareao
sudo apt-get update
sudo apt-get install touchpad-indicator


gconftool-2 --set --type boolean /desktop/gnome/peripherals/touchpad/touchpad_enabled true







