echo "« Apple Updates The Mac Mini
Dell Argues That Ubuntu Is Safer Than Windows »
Convert WAV To MP3 On Ubuntu 10.04 Lucid Lynx
By Jonathan Moeller - Last updated: Tuesday, June 15, 2010 - Save & Share - 13 Comments

If you have a WAV file that you want to convert to an MP3, it’s possible to do so quite easily and simply on a Ubuntu 10.04 Lucid Lynx system. You just need two software packages: the Ubuntu Restricted Extras packages, and the GNOME Sound Converter application. Here’s how to install them.

First, you’ll need to install the MP3 codec in the Ubuntu Restricted Extras package (note that you should only install this package if it is legal to do so in your country or residence). Ubuntu by default doesn’t include an MP3 codec due to licensing issues. However, it’s quite simple to install the Ubuntu Restricted Extras package, which contains the codec. To do so, open up a Terminal window and type this command:
sudo apt-get install -y ubuntu-restricted-extras
"
read readline

sudo apt-get install -y -y ubuntu-restricted-extras
echo "Enter your password to authenticate, and apt-get will download and install the Ubuntu Restricted Extras packages for you.

Next, you’ll need to install the Sound Converter program. Return to your Terminal window and type this command:
sudo apt-get install -y soundconverter
"
read readline
sudo apt-get install -y -y soundconverter


echo "After you enter your password to authenticate, apt-get will download and install SoundConverter and its necessary dependencies. After the installation is complete, you can run SoundConverter by going to the Applications menu, to the Sound & Video category, and clicking on the icon for SoundConverter. Once the program has launched, go to the Edit menu, and to the Options item. From there you can set the kind of output you want the program to produce (OGG files, MP3 files, or AAC files), as well as the destination folder for the converted files. Once you’ve selected your preferences, hit the Close button, and then Add Files on the program’s main toolbar to choose the files you want to convert.

-JM"
read readline

