echo "setting_pu_sb2_from_scratch_with_raspberry_pi
"

echo "
7Sep/1110
Setting up Scratchbox2 from scratch (for the Raspberry Pi)

It has been confirmed that binaries built using this method will run on real Raspberry Pi hardware (alphaboard).

Below is the method i used to setup Scratchbox2. I am doing this using a Ubuntu 11.4 virtual machine in VirtualBox. It works for me but YMMV.

Because the version of Scratchbox2 and qemu available in the Ubuntu repositories are pretty old and the version of qemu available doesn't have support for the arm1176 I am going to use the git versions of qemu and Scratchbox2.
"

mkdir RaspberryPi

cd RaspberryPi

git clone git://gitorious.org/scratchbox2/scratchbox2.git

git clone git://git.qemu.org/qemu.git

 

echo "You'll also need an ARM toolchain.Â Unless you want to build your own ARM toolchain you'll want to download the codesourcery ARM toolchain.Â https://sourcery.mentor.com/sgpp/lite/arm/portal/release1803
"

cd ~/RaspberryPi

wget https://sourcery.mentor.com/sgpp/lite/arm/portal/package8739/public/arm-none-linux-gnueabi/arm-2011.03-41-arm-none-linux-gnueabi-i686-pc-linux-gnu.tar.bz2

tar xjvf arm-2011.03-41-arm-none-linux-gnueabi-i686-pc-linux-gnu.tar.bz2

 
echo "
You will now have the codesourcery ARM toolchain in the directory ~/RaspberryPi/arm-2011.03

Now that you have a toolchain available it's time to build Scratchbox2 and qemu. Earlier you cloned the latest git versions available and if you haven't already got them installed you'll need to install "fakeroot" and "realpath" using your distributions package management system. To build and install Scratchbox2.
"

cd ~/RaspberryPi/scratchbox2

mkdir ../sb2

./autogen.sh

make install prefix=$HOME/RaspberryPi/sb2

Then build and install qemu

cd ~/RaspberryPi/qemu

./configure --prefix=$HOME/RaspberryPi/sb2 --target-list=arm-linux-user

make && make install

echo "Now that your toolchain, scratchbox2 and qemu are installed you'll need to seedÂ your development environment with some libs, include files and binaries and initilize Scratchbox2
"

mkdir ~/RaspberryPi/devel

cd ~/RaspberryPi/devel

export PATH=$HOME/RaspberryPi/sb2/bin:$PATH

cp -a ~/RaspberryPi/arm-2011.03/arm-none-linux-gnueabi/libc/{lib,etc,usr} .

sb2-init Raspi $HOME/RaspberryPi/arm-2011.03/bin/arm-none-linux-gnueabi-gcc

echo "This will generate a working target configuration. If anything fails you can redo it again manually after fixing the problem.

You'll probably want to add
"

echo "export PATH=$HOME/RaspberryPi/sb2/bin:$PATH
" >>~/.bashrc

echo "to your .bashrc as well

Now you have a working cross compile environment for the RaspberryPi (it isn't optimised or tweaked for the hardware but it's good enough for now and can be improved at a later date when we have more details about the hardware in particular the GPU and CPU).

To actually test that everything is working correctly write a small program (a hello, world program is a good choice).

raspberry@raspberrypi-VirtualBox:~/RaspberryPi/devel$ "

gcc hello.c -o hello
file hello
echo "hello: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.15, not stripped
raspberry@raspberrypi-VirtualBox:~/RaspberryPi/devel$ sb2 gcc hello.c -o hello
raspberry@raspberrypi-VirtualBox:~/RaspberryPi/devel$ file hello
hello: ELF 32-bit LSB executable, ARM, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.16, not stripped
raspberry@raspberrypi-VirtualBox:~/RaspberryPi/devel$ "

sb2 ./hello
hello, world

echo "If you have any questions you can find me on the raspberrypi forum, the irc channel or contact me via this blog.

[Addendum: Instead of seeding usign the libs and include files etc. from the codesourcery toochain you can use a rootfs of any ARM based distro. Just download an ARM rootfs from somewhere (exercise left for the user) and as root extract it into the ~RaspberryPi/devel directory and then chown -R user ~/RaspberryPi/devel and chgrp -R user ~/RaspberryPi/devel -- If you user a debian based rootfs (squeeze) the you can use apt to update and upgrade the files in the rootfs using the command
i"

sb2 -eR apt-get update

sb2 -eR apt-get upgrade

echo "]

 
Share
Tagged as: qemu, raspberrypi, scratchbox2 Leave a comment
Comments (10) Trackbacks (2) ( subscribe to comments on this post )

    Hans PUFAL
    September 7th, 2011 - 04:39

    On the line :

    git clone http://git.qemu.org/qemu.git

    I found that did not work but

    git clone git://git.qemu.org/qemu.git

    seems to work fine.
    ( REPLY )
        Hans PUFAL
        September 7th, 2011 - 05:01

        Seems I typed too soon, it runs the count of objects but hangs at that point without downloading. I think that git.qemu may be having problems, perhaps too many Rpi downloads ;-)

        On the positive side, the SB2 and the toolchain downloads without a problem and SB2 builds.
        ( REPLY )
        Russell
        September 7th, 2011 - 10:01

        yes sorry. brain said one thing, hands typed another. my only excuse is a lap full of cats and the lateness of the hour
        ( REPLY )
    diablo 3
    September 7th, 2011 - 09:56

    Everything is really open and extremely clear explanation of troubles. was truly data. Your site is extremely useful. Many thanks for sharing.
    ( REPLY )
    Hans PUFAL
    September 7th, 2011 - 16:09

    After several unsuccessful attempts I used the –progress option to git clone and the download happened after the object count ended.

    qEMU configure complained about needing glib-2.0, the solution is to install libgtk2.0-dev

    The make of qemu just finished ….

    The line

    cp -a ~/RaspberryPi/arm-2011.03/arm-none-linux-gnueabi/libc/{lib, etc.usr} .

    is interpreted as :

    cp -a ~/RaspberryPi/arm-2011.03/arm-none-linux-gnueabi/libc/lib .
    cp -a ~/RaspberryPi/arm-2011.03/arm-none-linux-gnueabi/libc/etc .
    cp -a ~/RaspberryPi/arm-2011.03/arm-none-linux-gnueabi/libc/usr .

    The line
    export PATH=$HOME/RaspberryPi/arm-2011.03/bin:$HOME/RaspberryPi/sb2:$PATH
    should read
    export PATH=$HOME/RaspberryPi/arm-2011.03/bin:$HOME/RaspberryPi/sb2/bin:$PATH

    and
    sb2-init Raspi arm-none-linux-gnuabi-gcc
    should be
    sb2-init Raspi arm-none-linux-gnueabi-gcc

    With these changes, my sb2-init succeeds !!
    ( REPLY )
        Russell
        September 7th, 2011 - 18:17

        yes thanks. i have been fixing it up during the day as i was running through it again and also forum user ahven who has been telling me where the typos were. it should all be fixed now.
        ( REPLY )
    Russell
    September 7th, 2011 - 19:33

    Apparently the links for the codesourcery changed earlier today. i’ve now fixed them so all should be good again
    ( REPLY )
    eggn1n3
    September 10th, 2011 - 16:16

    I think there is a typo:
    sb2-init Raspi $HOME/RaspberryPi/arm-2011.03/bin/arm-none-linux-gneabi-gcc
    Should be
    sb2-init Raspi $HOME/RaspberryPi/arm-2011.03/bin/arm-none-linux-gnueabi-gcc
    (missing “u” in gnueabi-gcc)
    ( REPLY )
    eggn1n3
    September 10th, 2011 - 16:30

    Ok, besides the typo, it works great. The executable even works on my Nokia N900.
    ( REPLY )
    TGM
    September 17th, 2011 - 11:32

    Here are the packages you need to install in Ubuntu (11.04, x64) for the howto to work straight away!
    build-essential git fakeroot realpath automake libglib2.0-dev g++-multilib zlib1g-dev libglib2.0-dev
    ( REPLY )


Leave a comment

Name (required)

Email (required)

Website

	
reCAPTCHA challenge image
	
		
Privacy & Terms
		Get a new challenge 	
Get an audio challenge
Help
	
 
Virtualbox VM for RaspberryPi development » « Cheap Zipit Z2′s
Pages

    About
    Donate
    Contact

Recent Posts

    OSHW Document Jam
    RaspberryHunt Part 2
    RaspberryHunt Part 1
    Happy Anniversary Raspberry Pi
    Whose Raspberry Pi is online (or any other XMPP enabled device)

Recent Comments

    Jason on The Land of Green Ginger by Noel Langley
    Jason on Using sshfs on the Raspberry Pi (or how not to wear out your SDCard)
    Elorian on Setting up Prosody on the Raspberry Pi for house/apartment/secret club house-wide chatroom
    Burrito on Setting up Prosody on the Raspberry Pi for house/apartment/secret club house-wide chatroom
    PRISM Free Chat on Linux | The Linux Action Show! | Jupiter Broadcasting on Setting up Prosody on the Raspberry Pi for house/apartment/secret club house-wide chatroom

Calendar
September 2011 M 	T 	W 	T 	F 	S 	S
« Aug 	  	Oct »
 	1	2	3	4
5	6	7	8	9	10	11
12	13	14	15	16	17	18
19	20	21	22	23	24	25
26	27	28	29	30 	 
Archives
Twitter

    I had a new box of girl scout cookies this morning and someone seems to have eaten them all 11:07:23 AM March 28, 2013 ReplyRetweetFavorite
    RT @ohsummit: Join OSHWA for the First Open Source Hardware Documentation Hack-a-thon! http://t.co/t3Ei9SFxuE 10:45:17 AM March 28, 2013 ReplyRetweetFavorite
    oh no. twiglets are ruined for me now :( i can't have them any more http://t.co/QQbGVZBV2Q #TwigletsRuinedForMeNow 08:39:16 AM March 28, 2013 ReplyRetweetFavorite
    RT @potatono: The 7 days later blog shows stuff we're going to get rid of at NYC Resistor. http://t.co/npaXc0TMGN Follow if you like fr ... 04:14:03 PM March 27, 2013 ReplyRetweetFavorite
    RT @make: Do you have a Raspberry Pi project & want to win a Printrbot Jr 3D printer? Thought so! Check out this contest: http://t.c ... 10:25:45 AM March 27, 2013 ReplyRetweetFavorite

Tags
keyboard console USB arm scratchbox2 rootfs hacking scratchbox iz2se virtualbox raspberrypi raspberry pi utility warrick buy zipitz2 virtual machine ez2s linux z2shell iz2s power power management ubuntu quiz serial vm qemu cobol keymap
COBOL

    Add 1 to COBOL
    Open COBOL

Miscellaneous

    Discursive Labs
    Retr0Bright
    sugru

Raspberry-Pi

    Pimoroni
    Raspberry-Pi wiki
    Raspberry-Pi.org

Retro

    Binary Dinosaurs
    Camputer's Lynx
    Club100
    Grundy Newbrain
    Ira Goldklang's TRS-80 Revived Site
    Nascom
    Olivetti M20
    Psion Organiser2
    Retroleum
    World of Spectrum
    xtrs
    Z80.info

Zipit Z2

    ama's zipit page
    Brianith's Zipit site
    deeice's blog
    Geordy's Blog
    Hunter Davis's Zipit Hacking
    Marex's Blog
    Mozzwald's Blog
    nulluser's Zipitbot
    OpenZipit
    OpenZipit Part Deux
    Ray's Blog
    Sweetlilmre's Blog
    Uhrheber's Blog
    wejp's blog
    Wicknix's z2sid
    Zashi's ebindkeys
    Zipit Wireless Inc's Wiki
    Zipit2System

Meta

    Log in
    Entries RSS
    Comments RSS
    WordPress.org

Copyright © 2013 Executing Gummiworms · Powered by WordPress
Lightword Theme by Andrei Luca Go to top ↑


"

