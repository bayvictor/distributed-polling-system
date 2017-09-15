xmodmap -e 'keycode 0x42 = Caps_Lock'
echo "
or

setxkbmap -option

The commands above work just fine to restore the default behaviour, which I hardly ever need, luckily.

I normally remap the capslock to Control (luckily VI/VIM supports CTRL-C instead of ESC) with the following command:
i"

#setxkbmap -option ctrl:nocaps -layout gb
setxkbmap -option ctrl:nocaps -layout us 
