echo "Alt+Fn+F7 toggles the touchpad on and off."
read readline

sudo -s

sudo apt-get install -i xul-ext-mozgest 


deviceId=`xinput list|grep Pad|cut -d"=" -f2|cut -d"[" -f1`

echo "deviceId=$deviceId"
xinput set-prop $deviceId "Device Enabled" 0


gconftool --type bool --set /desktop/gnome/peripherals/touchpad/touchpad_enabled true

sudo add-apt-repository ppa:atareao/atareao
sudo apt-get update
sudo apt-get install touchpad-indicator


gconftool-2 --set --type boolean /desktop/gnome/peripherals/touchpad/touchpad_enabled true


 xinput set-prop "SynPS/2 Synaptics TouchPad" "Synaptics Two-Finger Width" 8
 xinput set-prop "SynPS/2 Synaptics TouchPad" "Synaptics Two-Finger Pressure" 40
 xinput set-prop "SynPS/2 Synaptics TouchPad" "Synaptics Two-Finger Scrolling" 1 1
 xinput set-prop "SynPS/2 Synaptics TouchPad" "Synaptics Edge Scrolling" 0 0 0
 xinput set-prop "SynPS/2 Synaptics TouchPad" "Synaptics Tap Action" 9 3 8 0 1 2 3


xinput list-props "SynPS/2 Synaptics TouchPad"





