sudo apt-get install -y  libmysqlclient-dev 

sudo apt-get install -y  mysql-server-core-5.1
read read_line
echo "HOWTO: compiling mediatomb + ffmpegthumbnailer + all libraries for Ubuntu... and PS3 :)"

echo "Today I'd like to talk about mediatomb, a media server with a nice web user interface allowing you to stream your digital media through your home network on a variety of 'Universal Plug and Play' (UPnP) compatible devices... such as the PS3 :)"
read read_line
echo "Of course, you could just go and install a packaged version of the last official release (0.11) with apt-get, but:

   1. 0.11 was released in March'08, which means that you'll be missing the newest features
   2. that's not fun :)

So, let's get to work and take care of all dependencies needed to build mediatomb from source. This procedure was successfully performed on Ubuntu 8.04 and 8.10.

1) Installing ffmpegthumbnailer

ffmpegthumbnailer is a small tool which uses ffmpeg to generate video thumbnails. These thumbnails will be displayed by mediatomb while you're browsing your video collection.

[Updated on 2008/01/02] This supposes that you have built ffmpeg. If not, you may be missing a number of libraries: please check the comments below for solutions.

First, we need to install libpng:"
read read_line

echo "========== quick & dirty install .... =========="
sudo apt-get install -y libpng12-dev
sudo apt-get install -y libpng-dev
sudo apt-get install -y libavutil-dev
sudo apt-get install -y  libavformat-dev 
sudo apt-get install -y libavcodec-dev
sudo apt-get install -y  libswscale-dev 
sudo apt-get install -y libffmpegthumbnailer-dev
read read_line
sudo apt-get install -y libdvdread-dev 
sudo apt-get install -y libdvdnav-dev
sudo apt-get install -y libsqlite3-dev
sudo apt-get install -y libtag1-dev
sudo apt-get install -y libexpat1-dev
sudo apt-get install -y libexif-dev
sudo apt-get install -y libmp4v2-dev
sudo apt-get install -y libmagic-dev
sudo apt-get install -y libcurl4-openssl-dev
sudo apt-get install -y libmozjs-dev
sudo apt-get install -y libavformat-dev
sudo apt-get install -y libswscale-dev
read read_line
echo "================================================"




echo "Now, let's fetch the ffmpegthumbnailer source and build it:"
cd ~/src/glen/dlna
read read_line
#wget http://ffmpegthumbnailer.googlecode.com/files/ffmpegthumbnailer-1.3.0.tar.gz
#tar xvfz ffmpegthumbnailer-1.3.0.tar.gz
#cd ffmpegthumbnailer-1.3.0

#wget http://ffmpegthumbnailer.googlecode.com/files/ffmpegthumbnailer-2.0.5.tar.gz
#tar -zxvf ffmpegthumbnailer-2.0.5.tar.gz
#cd  ~/src/glen/dlna/ffmpegthumbnailer-2.0.5
#./configure --prefix=/usr/local
#make
#sudo make install
#read read_line
#echo "OK, let's move on.
##  configure: error:  +Could not find ffmpeg (libavutil libavformat libavcodec libswscale)

echo "2a) Installing libdvdnav and libdvdread from source

These two libraries are used to browse DVD file structures: mediatomb needs them to read and stream DVD ISO images.

Since we're going to build the very latest mediatomb version, let's make sure we have up to date libs as well.

You do need to build and install libdvdread before libdvdnav, or the latter won't link."
echo "read read_line
 wget ftp://ftp6.mplayerhq.hu/MPlayer/releases/dvdnav/libdvdread-4.1.3.tar.bz2
 bzip2 -d libdvdread-4.1.3.tar.bz2
 tar xvf libdvdread-4.1.3.tar
 ./configure2 --prefix=/usr/local --enable-shared
 make
 sudo make install

 wget ftp://ftp6.mplayerhq.hu/MPlayer/releases/dvdnav/libdvdnav-4.1.3.tar.bz2
 bzip2 -d libdvdnav-4.1.3.tar.bz2
 tar xvf libdvdnav-4.1.3.tar
 ./configure2 --prefix=/usr/local --enable-shared
 make
 sudo make install"

echo "2b) Installing libdvdnav and libdvdread from APT

Both are available as APT packages (libdvdread-dev and libdvdnav-dev), but they're not up to date on Ubuntu 8.04. Anyway, if you don't want to build them, here's how to install them quickly:

ubuntu% "
read read_line
sudo apt-get install -y libdvdread-dev 
sudo apt-get install -y libdvdnav-dev

echo "3) Installing everything else

Sqlite3 is one of the two databases that mediatomb can use (the other is mySQL).

ubuntu% "
sudo apt-get install -y libsqlite3-dev

echo "Libtag is needed to read tags in MP3 files, FLAC files and so on:

ubuntu% "
sudo apt-get install -y libtag1-dev

echo "Libexpat is needed parse XML files:

ubuntu% "
sudo apt-get install -y libexpat1-dev

echo "Libexif is needed to read tags stored in some digital pictures.
read read_line
ubuntu% "
read read_line
sudo apt-get install -y libexif-dev

echo "Libmp4v2 is needed to parse mp4 files.

ubuntu% "
sudo apt-get install -y libmp4v2-dev

echo "Libmagic helps to find the MIME type of a file based on the 'magic number' usually stored in the file header.

ubuntu% "
sudo apt-get install -y libmagic-dev

echo "Libcurl is used to fetch web content using HTTP requests. This is how mediatomb can fetch YouTube content and stream it.

ubuntu% "
sudo apt-get install -y libcurl4-openssl-dev

echo "Last, libmozjs is the JavaScript engine used by mediatomb.

ubuntu% "
sudo apt-get install -y libmozjs-dev

echo "4) Building mediatomb

Let's fetch the latest sources from the Subversion repository:

ubuntu% "
echo "svn co https://svn.mediatomb.cc/svnroot/mediatomb/trunk/mediatomb mediatomb"
read read_line

svn co https://svn.mediatomb.cc/svnroot/mediatomb/trunk/mediatomb mediatomb

echo "Now, let's generate the configure script and run it (you need autoconf and automake for this):

ubuntu% "
cd mediatomb
#ubuntu% 
autoreconf -i
#ubuntu% 
./configure --prefix=/usr/local
echo "lots of output removed
CONFIGURATION SUMMARY ----
sqlite3 : yes
mysql : missing
libjs : yes
libmagic : yes
inotify : yes
libexif : yes
id3lib : disabled
taglib : yes
libmp4v2 : yes
libdvdnav : yes
ffmpeg : yes
ffmpegthumbnailer : yes
external transcoding : yes
curl : yes
YouTube : yes
Weborama : disabled
Apple Trailers : yes
SopCast : disabled
libextractor : disabled
db-autocreate : yes"

echo "As you can see, we have pretty much enabled everything (again, sqlite3 is preferred over mySQL, and taglib over id3lib). Support for SopCast and Weborama isn't completely ready yet, so it's probably safer to leave them out.

All right, let's build mediatomb:

ubuntu% "
make
#ubuntu% 
sudo make install
#ubuntu% 
sudo ldconfig

echo "And now...

ubuntu% "
mediatomb

read read_line; echo "all scripts done. press ^c to break! Else comments follow"
read read_line
echo "MediaTomb UPnP Server version 0.12.0 - http://mediatomb.cc/
===============================================================================
Copyright 2005-2008 Gena Batsyan, Sergey Bostandzhyan, Leonhard Wimmer.
MediaTomb is free software, covered by the GNU General Public License version 2


All right. Let's power up the PS3 and see if it can see the mediatomb server.



Yes it does. Now using the mediatomb GUI, in just a few clicks, I added some pictures and music to my library. They are almost immediately visible on the PS3:



Not bad at all! That's it for the mediatomb installation. There's still plenty of configuration to do, but this will be the subject of another entry :)

Related Posts by Categories
howto "

echo "
    * HOWTO: H.264 YouTube videos in mediatomb (no more transcoding for PS3!)
    * HOWTO: building evolution on Ubuntu 8.10 (to fix IMAP slowness...)
    * HOWTO: processing multichannel audio (DTS, AC3, WAV)
    * HOWTO: converting mkv files to play on the PS3
    * HOWTO: ffmpeg & x264 presets
    * HOWTO: compiling mediainfo (CLI & GUI) on Ubuntu
    * HOWTO: adding Last.fm scrobbling to mediatomb
    * HOWTO: quick reference on audio & video encoding with ffmpeg
    * HOWTO: setting up a VOD server with VLC
    * Mediatomb 0.12 on PS3: video thumbnails, YouTube and Apple movie trailers

mediatomb

    * Update on lastfmlib and mediatomb
    * Status update on mediatomb 0.12
    * HOWTO: H.264 YouTube videos in mediatomb (no more transcoding for PS3!)
    * HOWTO: adding Last.fm scrobbling to mediatomb
    * Mediatomb 0.12 on PS3: video thumbnails, YouTube and Apple movie trailers

open source

    * VLC 1.0 released
    * HOWTO: compiling VLC 0.9.9 + live555 + all major codecs on Ubuntu 8.10
    * Clouds, clouds, clouds
    * ffmpeg 0.5 released
    * Update on lastfmlib and mediatomb
    * Status update on mediatomb 0.12
    * VirtualBox 2.1.2 released
    * HOWTO: H.264 YouTube videos in mediatomb (no more transcoding for PS3!)
    * HOWTO: building evolution on Ubuntu 8.10 (to fix IMAP slowness...)
    * HOWTO: processing multichannel audio (DTS, AC3, WAV)

Written by: Julien Simon à l'adresse 1:14 PM
Tags: howto, mediatomb, open source
40 commentaires:

Dean said...

    Thanks for this, linking to it from my blog.

    A little pointer to anyone compiling the ffmpegthumbnailer that gets the error

    configure: error: +Could not find ffmpeg. Please update PKG_CONFIG_PATH to point at location of ffmpeg pkgconfig files directory.

    Run this..."

#    cat config.log | grep "No package"

echo "    and that will tell you what packages you need to download. Make sure they are the dev ones!

    i.e. mine said

    No package 'libavformat' found
    No package 'libswscale' found

    so i ran

    sudo apt-get install -y libavformat-dev libswscale-dev

    Cheers,
    Dean
    My Coding Blog
    December 27, 2008 11:07 AM 
JS said...

    Hi Dean, you're right: I assumed ffmpeg was already installed. I'll update the entry accordingly. Cheers!
    December 27, 2008 10:40 PM 
iglooc00l said...

    Hi JS,

    I've really enjoyed your blog and using your howtos. I'm having a problem compiling mediatomb though.
    I started with your other tutorial compiling ffmpeg + x264 + MP3 + Xvid + AMR on Ubuntu (everything
    appears to have gone smooth) and have since moved on to this mediatomb howto. When I 'make'
    mediatomb I receive the following.

    /usr/local/lib/libavformat.so: undefined reference to `av_fifo_realloc2'
    /usr/local/lib/libavcodec.so.52: undefined reference to `av_memcpy_backptr'
    /usr/local/lib/libavcodec.so.52: undefined reference to `av_lfg_init'

    I read on another one of your howtos how someone else was having similar issues. It was recommended
    to remove the a and so files for the offending. Where do I delete from if these files exist? My /usr/lib
    or the source directory for what I'm compiling?

    Thanks for some great reading!

    Ig
    December 30, 2008 2:03 AM 
Magnus said...

    I get the same.

    Did apt-get remove libavcodec-dev, then deleted libavcodec.a and libavcodec.so from /usr/local/lib, then installed libavcodec-dev again. Still got the same error when doing 'make'
    January 1, 2009 4:33 PM 
JS said...

    @iglooc00l:

    yes, it's the same problem as the other person. You need to remove any previous copy of these libraries (.a & .so). They have probably been installed using APT, so you may first try to remove them with 'apt-get remove libavcodec-dev', etc.

    If that doesn't work, just look for the offending files in /usr/lib and delete them (or move them to a backup directory if you're worried). Then just run 'ldconfig' to refresh the library cache and you should be fine.
    January 2, 2009 10:13 AM 
JS said...

    @Magnus:

    you need to check for older libs in /usr/lib. The ones in /usr/local/lib are the one you built :)
    January 2, 2009 10:19 AM 
Magnus said..."

#    Okay, new snag. "./configure" ffmpegthumbnailer

echo "    configure: error: +Could not find ffmpeg. Please update PGK_CONFIG_PATH to point at location of ffmpeg pkgconfig files directory.
"
#    What gives...When I "./configure" mediatomb, it says it finds ffmpeg. Why doesnte ffmpegthumbnailer suddenly?

echo "    This is hard for someone who hasn't used linux in 10 years :D
    January 2, 2009 3:12 PM 
JS said...

    @Magnus: looks like you have the same problem as Dean (1st comment on this entry). Please try his suggestion, it should help.
    January 2, 2009 3:17 PM 
Stefan said...

    Hi JS,
    what do I need to add to the config.xml to make mediatomb play DVD ISO files?
    The original config.xml contains only these two lines (less-than signs removed because of html code...):"

    treat mimetype="application/x-iso9660" as="dvd"/>
    treat mimetype="application/x-iso9660-image" as="dvd">

    Well, that's obviously not enough to make mediatomb recognize iso files so I added

    map from="iso" to="application/x-iso-9660-image"/>

    to the mappings section, but that did'nt help... My PS3 shows iso files on mediatomb as "incompatible data".

    As there's an extra import script (import-dvd.js) I assume a new category should show up if mediatomb recognizes an iso file?

    Maybe you could post the lines I need to add/edit in the config.xml?

    Greets Stefan
    January 2, 2009 7:44 PM 
Stefan said...

    Oh, of course it's

    map from="iso" to="application/x-iso9660-image"/>
    January 2, 2009 7:50 PM 
Magnus said...

    'sudo apt-get remove libavcodec-dev' and removing the .a and .so files in /usr/lib did the trick.

    Couldn't have done it without this blog. And I learned a LOT in the process, thanks a bunch JS.

    Now I just need to figure out how to set up transcoding =)
    January 2, 2009 8:02 PM 
Magnus said...

    Guess I spoke too soon.

    'MediaTomb UPnP Server version 0.12.0 - http://mediatomb.cc/

    Output removed

    2009-01-02 20:07:35 INFO: Loading configuration from: /home/nannus/.mediatomb/config.xml
    2009-01-02 20:07:35 INFO: Checking configuration...
    2009-01-02 20:07:35 ERROR: /usr/share/mediatomb/web : 20 x No such file or directory'
    January 2, 2009 8:10 PM 
Magnus said...

    Fixed. Just needed to delete config.xml

    Sorry for chattering all over your blog =)
    January 2, 2009 8:30 PM 
Stefan said...

    Uhm, my typo was only in the comment, not in the config.xml...
    So my problem still persists: How do I need to configure mediatomb to play DVD ISO files? :-/

    By the way, JS, thanks for your great tutorials on how to set up mediatomb for online content, last.fm, ffmpegthumbnailer and stuff... I got it all up and running - perfect :)
    January 3, 2009 2:43 PM 
JS said...

    @Stefan: AFAIK, this is not fully functional yet. The mediatomb guys will try to complete for the 0.12 release.
    January 4, 2009 12:13 PM 
Stefan said...

    Alright, thanks a lot :)
    Do you know when 0.12 will be released? The last news entry on mediatomb.cc regarding the release date (2008-09-27) says "[...] we can release it this year"...
    January 4, 2009 3:30 PM 
royw said...

    Small typo, the path to libdvdread should be:

    wget ftp://ftp6.mplayerhq.hu/MPlayer/releases/dvdnav/libdvdread-4.1.3.tar.bz2

    i.e., ../dvdnav/.. instead of ../dvdread/..

    Thank you
    January 5, 2009 7:34 AM 
JS said...

    @royw: grrr, just fixed it. Thanks :)
    January 5, 2009 10:34 AM 
Anonymous said...

    Thanks for all your work on this... I found it after getting everything except ffmpegthumbnailer working and installed. When I try to install it I receive the same error over and over again no matter which version I try to install:

    libffmpegthumbnailer/.libs/libffmpegthumbnailer.so: undefined reference to `BZ2_bzDecompress'
    libffmpegthumbnailer/.libs/libffmpegthumbnailer.so: undefined reference to `BZ2_bzDecompressEnd'
    libffmpegthumbnailer/.libs/libffmpegthumbnailer.so: undefined reference to `BZ2_bzDecompressInit'
    collect2: ld returned 1 exit status
    make[2]: *** [ffmpegthumbnailer] Error 1


    Have any clues on how to fix it?
    January 14, 2009 6:52 PM 
JS said...

    @Anonymous: that's weird. I can't find these symbols in my build:

    ubuntu% pwd
    /home/julien/tmp/ffmpegthumbnailer-1.3.0/src/libffmpegthumbnailer/.libs
    ubuntu% nm *.o *.so |grep BZ2
    ubuntu%

    Can you run the same command and post the output?
    January 14, 2009 7:25 PM 
Anonymous said...

    sorry it took a bit to get back to you. I appreciate the fast response. After the initial tries it started spewing errors about gcc 4.2 and a bug. Rebooted the system and tried to compile ffmpegthumbnailer again and it succeeded! I now have all working that should be working. Not sure if thumbnails are supposed to show on the PS3 or not but I do have flac transcoding.

    Did I get you right when you said the ISO stuff is still not functional yet for the PS3?

    Thx again!
    January 15, 2009 2:19 AM 
Bert said...

    Thanks for this how-to all is working well except I can't seem to get mediatomb start at boot, any ideas?
    January 19, 2009 4:02 PM 
wheaties said...

    so first off thanks for such a great tutorial!! I am having one tiny problem with getting mediatomb to start properly. Everything compiled without errors but when I start mediatomb I get the following error:

    mediatomb: symbol lookup error: /usr/local/lib/libavcodec.so.52: undefined symbol: av_gcd

    I have tried reinstalling libavcodec without any luck. Any ideas? Thanks in advance!
    January 20, 2009 2:33 AM 
Julien Simon said...

    @Bert: one way to do it is "System" > "Preferences" > "Sessions" and add mediatomb to the list.

    @Wheaties: this symbol is in libavutil. My guess is that you have an older version of the library in /usr/lib. You should either uninstall it, or define LD_LIBRARY_PATH in you .cshrc (or equivalent):

    LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
    export LD_LIBRARY_PATH
    January 20, 2009 11:47 AM 
Julien Simon said...

    @Anonymous: yes, AFAIK, ISO support is not there yet. I haven't seen any recent SVN update on this but I'll keep my eyes peeled :)
    January 20, 2009 11:49 AM 
Bert said...

    @js I'm running mediatomb on a server, so adding it to sessions isn't an option. I did find some startup-scripts but somehow they don't do the job. So if someone has it working, please post it.

    greetings Bert
    January 22, 2009 12:50 AM 
Anonymous said...

    I thought I read in one of the TUT's, thanks by the way working great, that vlc was used in the past to stream the youtub content, or the apple trailers? if that's the case would it be possible to do the same with the iso files until mediatomb is ready? Iso saves so much space and for us poor folk means less $$
    January 30, 2009 12:48 AM 
gogobambi said...

    I'm getting this error when running mediatomb.

    $ mediatomb
    mediatomb: error while loading shared libraries: libavcodec.so.51: cannot open shared object file: No such file or directory

    I compiled ffmpeg from source following an earlier post on this blog:
    /usr/lib/libavcodec.a
    /usr/lib/libavcodec.so
    /usr/lib/libavcodec.so.52
    /usr/lib/libavcodec.so.52.14.0

    Any ideas?

    Also ran into this error on ffmpegthumbnailer make: http://code.google.com/p/ffmpegthumbnailer/issues/detail?id=24&q=moviedecoder

    Managed to get around it by following the solution of someone on the ubuntu forums, using prevu to install 1.3.0 from jaunty:
    http://ubuntuforums.org/showthread.php?t=1064609
    February 11, 2009 7:11 AM 
gogobambi said...

    Fixed by recompiling/installing everything with --prefix=/usr/local instead of --prefix=/usr.

    Had to go back and reinstall a lot of other stuff for /usr/local as well, but I should probably have done that a long time ago.
    February 11, 2009 11:56 AM 
homerlinux said...

    Great tutorial!

    Almost everything is working ok.

    Somebody asked for a /etc/init.d startup service script. Here is mine for Ubuntu 8.10 (based in te script from package mediatomb-daemon, slightly modified). It works fine for me. Configuration un /etc/mediatomb/config.xml.
    Create autostart/autostop links with "sudo update-rc.d mediatomb defaults"

    Good luck



    # Read configuration variable file if it is present
    [ -r $DEFAULT ] && . $DEFAULT

    # Load the VERBOSE setting and other rcS variables
    [ -f /etc/default/rcS ] && . /etc/default/rcS

    # Define LSB log_* functions.
    # Depend on lsb-base (>= 3.0-6) to ensure that this file is present.
    . /lib/lsb/init-functions

    # Start the daemon if NO_START is disabled in DEFAULT
    if [ "$NO_START" = "yes" ]; then
    test "$1" = "start" && \
    {
    log_warning_msg "$NAME: Not starting $DESC."
    log_warning_msg "$NAME: Disabled in $DEFAULT."
    }
    exit 0
    fi

    # Run as root if USER not specified
    if [ ! $USER ]; then
    USER=root
    fi

    # Check for an invalid user or one without a home directory
    eval USERHOME=~$USER
    if [ "${USERHOME#/}" = "${USERHOME}" ]; then
    log_failure_msg "$NAME: The user '$USER' specified in $DEFAULT is invalid."
    exit 1
    fi

    # Check if group is not specified and assign a proper group
    if [ -z $GROUP ]; then
    GROUP="$USER"
    fi

    if [ "$INTERFACE" != "" ] ; then
    INTERFACE_ARG="-e $INTERFACE"
    else
    INTERFACE_ARG=""
    fi

    DAEMON_ARGS="-c /etc/mediatomb/config.xml -d -u $USER -g $GROUP -P $PIDFILE -l $LOGFILE $INTERFACE_ARG $OPTIONS"

    #
    # Function that starts the daemon/service.
    #
    do_start() {
    # Return
    # 0 if daemon has been started
    # 1 if daemon was already running
    # 2 if daemon could not be started
    touch $PIDFILE
    chown $USER:$GROUP $PIDFILE
    touch $LOGFILE
    chown $USER:$GROUP $LOGFILE
    start-stop-daemon --start --quiet --pidfile $PIDFILE --exec $DAEMON \
    --test > /dev/null \
    || return 1
    start-stop-daemon --start --quiet --pidfile $PIDFILE --exec $DAEMON -- \
    $DAEMON_ARGS \
    || return 2
    }

    #
    # Function that stops the daemon/service.
    #
    do_stop() {
    # Return
    # 0 if daemon has been stopped
    # 1 if daemon was already stopped
    # 2 if daemon could not be stopped
    # other if a failure occurred
    start-stop-daemon --stop --quiet --retry=TERM/30/KILL/5 --pidfile $PIDFILE --name $NAME
    RETVAL="$?"
    [ "$RETVAL" = 2 ] && return 2
    rm -f $PIDFILE
    return "$RETVAL"
    }

    #
    # Function that sends a SIGHUP to the daemon/service.
    #
    do_reload() {
    start-stop-daemon --stop --signal 1 --quiet --pidfile $PIDFILE --name $NAME
    return 0
    }

    case "$1" in
    start)
    if [ -n "$INTERFACE" ]; then
    # try to add the multicast route
    if [ "$VERBOSE" != no ]; then
    {
    log_action_begin_msg \
    "$NAME: Trying to add the multicast route"
    $ROUTE_ADD $INTERFACE \
    && log_action_end_msg 0
    } || {
    true && \
    log_warning_msg "Failed to add multicast route. skipping."
    }
    else
    $ROUTE_ADD $INTERFACE >/dev/null 2>&1 || true
    fi
    fi
    log_daemon_msg "Starting $DESC" "$NAME"
    do_start
    case "$?" in
    0) log_end_msg 0 ;;
    1) log_warning_msg "$DESC" "'$NAME'" "was already started" ;;
    2) log_end_msg 1 ;;
    esac
    ;;
    stop)
    log_daemon_msg "Stopping $DESC" "$NAME"
    do_stop
    case "$?" in
    0)
    log_end_msg 0
    if [ -n "$INTERFACE" ]; then
    # try to add the multicast route
    if [ "$VERBOSE" != no ]; then
    {
    log_action_begin_msg \
    "$NAME: Trying to delete the multicast route"
    $ROUTE_DEL $INTERFACE \
    && log_action_end_msg 0
    } || {
    true && \
    log_warning_msg \
    "Failed to delete multicast route. skipping."
    }
    else
    $ROUTE_DEL $INTERFACE >/dev/null 2>&1 || true
    fi
    fi
    ;;
    1) log_warning_msg "$DESC" "'$NAME'" "was already stopped" ;;
    2) log_end_msg 1 ;;
    esac
    ;;
    reload|force-reload)
    log_daemon_msg "Reloading $DESC" "$NAME"
    do_reload
    log_end_msg $?
    ;;
    restart)
    #
    # If the "reload" option is implemented, move the "force-reload"
    # option to the "reload" entry above. If not, "force-reload" is
    # just the same as "restart".
    #
    log_daemon_msg "Restarting $DESC" "$NAME"
    do_stop
    case "$?" in
    0|1)
    sleep 1
    do_start
    case "$?" in
    0) log_end_msg 0 ;;
    1) log_end_msg 1 ;; # Old process is still running
    *) log_end_msg 1 ;; # Failed to start
    esac
    ;;
    *)
    # Failed to stop
    log_end_msg 1
    ;;
    esac
    ;;
    *)
    #echo "Usage: $SCRIPTNAME {start|stop|restart|reload|force-reload}" >&2
    echo "Usage: $SCRIPTNAME {start|stop|restart|force-reload}" >&2
    exit 3
    ;;
    esac
    February 13, 2009 10:55 PM 
Hed said...

    Hi, thanks for an excellent guide. I myself is using Fedora so I had a lite bit of work to do before i got it all right. However when I read DVD:s (ISO) something goes wrong :


    libdvdnav: Using dvdnav version 4.1.3
    libdvdread: Using libdvdcss version 1.2.10 for DVD access
    libdvdnav: DVD Title: Jumper Sample - FDSCR
    libdvdnav: DVD Serial Number: 386C306300005321
    libdvdnav: DVD Title (Alternative):
    libdvdnav: Unable to find map file '/home/Caine/.dvdnav/Jumper Sample - FDSCR.map'
    libdvdnav: DVD disk reports itself with Region mask 0x00400000. Regions: 1 2 3 4 5 6 8


    Anyone else seen this? <:P
    February 22, 2009 7:40 PM 
Hed said...

    Might add that i get this when i run the file from the ps3

    ERROR: DVD Image requested but title parameter is missing!
    February 22, 2009 8:22 PM 
Craig said...

    the include path for mp4 support seems wrong. Its looking for mp4.h but no package provides that header file on Debian. Shouldn't this be mp4v2.h?
    February 23, 2009 10:49 AM 
Hed said...

    When i transcode a .mkv file
    i get corrupt format.

    (on the top of my head, at work)
    in the terminal i can see a %in %out message beeing displayed twice.

    ffmpegthumbnailer however seems to be able to create a screenshot of the file .. This didn't go as smotth as i hoped < : )
    February 23, 2009 2:41 PM 
Julien Simon said...

    @Hed:

    AFAIK, ISO support isn't there yet (see http://juliensimon.blogspot.com/2009/01/status-update-on-mediatomb-012.html for more).

    Transcoding MKV is tricky (I don't do it myself). You should try converting the file from the command line using ffmpeg: if it doesn't work, then it's an ffmpeg issue, not a mediatomb issue.
    February 23, 2009 3:10 PM 
Hed said...

    @julien

    Ahh my bad. I just thougt it was as i saw that you had it in your config. < = )

    about the matroska issue:
    ffmpeg seems to be working correctly.
    When i run it with the ffmpeg script is outputs allot of :

    [mpeg4 @ 0x9dc0c50]Invalid and inefficient vfw-avi packed B frames detected

    but other then that it keeps on going. I must confess that i don't really know what that in tails. Video en/decoding is very new to me. :P
    February 23, 2009 4:32 PM 
wesg said...

    This is a great tutorial, and I've used it to install Mediatomb with 9.04 Jaunty. But I'm wondering how to install it so Mediatomb runs as a daemon, instead of forcing me to start it manually. There is nothing inside /etc/default/mediatomb and no program in the init.d folder. I'm also worried that if I install the daemon from the repository, it will overwrite this compiled version. Any suggestions?
    May 1, 2009 6:46 AM 
Anonymous said...

    it is worth mentioning that jpeg support is only enabled when jpeglib is installed before configureing ffmpegthumbnailer

    apt-get install -y libjpeg62-dev
    July 8, 2009 7:21 PM 
Jason said...

    Hi guys,
    I am new to ubuntu. I am trying to follow this utility. I installed ffmpegthumbnailer using apt, followed the rest of the tutorial using Jaunty, when I go to compile it says ffmpegthumbnailer ins not there. I installed it anyway and now I get the error "ERROR: /usr/share/mediatomb/web : 20 x No such file or directory"

    i can install mediatomb from apt, but I can't get my mp3 files to play so Itried this. Any suggestions
    December 2, 2009 1:13 AM 
Jason said...

    Error on last post, I meant to say I am using Karmic, not Jaunty
    December 2, 2009 1:14 AM 

Post a Comment
Liens vers ce message blog

  HOWTO: MKV en la PS3
    Desde hace un tiempo vengo pegándome con mi servidor casero para conseguir ver los matroska en HD en la tele a través de la PS3. Dicho así puede difícil de comprender… La idea es la siguiente: desde un PC compartiremos por red nuestras ... 
    Written by: caic à l'adresse March 31, 2010 4:04 PM 
  How to: Compile and run Mediatomb as a daemon with Ubuntu 9.04
    Since getting my PS3, then setting up my Ubuntu file server, I've really enjoyed watching movies on my TV. To get the media from computer to Playstation requires the use of software that employs the UPnP protocol, in the form of a DLNA ... 
    Written by: wesg à l'adresse September 23, 2009 4:26 PM 
  Building a Ubuntu fileserver: The Software
    After planning and building a Ubuntu-based fileserver, it's time to add software to the mix, so that the computer does the work it was originally meant for. In the case with my command-line only server, the software I added was for file ... 
    Written by: wesg à l'adresse August 12, 2009 7:44 PM 

Create a Link
Newer Post Older Post Home
Subscribe to: Post Comments (Atom)
Blog stats
Locations of visitors to this page free counters

Get the post feed   Get the comment feed
About me
Hello, my name is Julien SIMON. I live in the Paris area and I know a thing or two about computers. Feel free to visit me on LinkedIn.

"Your time is limited, so don't waste it living someone else's life. Don't be trapped by dogma — which is living with the results of other people's thinking. Don't let the noise of others' opinions drown out your own inner voice. And most important, have the courage to follow your heart and intuition. They somehow already know what you truly want to become. Everything else is secondary" - Steve Jobs, speech at Stanford University, June 2005

"Do you pirate water or electricity? No. Why? Because it's easier and safer to use the system provided by the utility company. And because whatever price they charge is acceptable to you, even if you don't really track it on a daily basis. And you don't have to worry if water will fit in this brand of cup, or if electricity will power this brand of coffee machine : it just WORKS. I believe that all digital content should follow this path" - Me, every time someone dares to mention DRM.

Twitter
profile
Julien SIMON
julsimon
julsimon profile

julsimon Wall Street Journal on Criteo : http://online.wsj.com/ar... #in #v 14 days ago · reply
julsimon profile

julsimon EMC agrees to purchase Isilon - http://t.co/aZyLBKW #in #v 36 days ago · reply
julsimon profile

julsimon ACTA & Loppsi : conference with Richard Stallman this Sunday in Paris (@Numerama) http://bt.io/GIKG #in #v 42 days ago · reply
julsimon profile

julsimon #Scrum @ #Criteo: Well, well, well. So long Pixmania, hello Criteo ! New company, new job… http://goo.gl/fb/ehghT #in 43 days ago · reply
julsimon profile

julsimon Is SE-Over? http://t.co/Umfudfu #in #v 47 days ago · reply
Join the conversation
Blog archive

    * ►  2010 (10)
          o ►  November (1)
                + Scrum @ Criteo
          o ►  September (1)
                + New Pixmania Pro websites
          o ►  June (2)
                + "They said it couldn't happen"
                + Certified Scrum Product Owner :)
          o ►  May (3)
                + Zzzzzzzz
                + New Pixmania & Pixmania Pro websites
                + RIP Dio, the greatest voice in Heavy Metal
          o ►  March (2)
                + New Dixons website live
                + New PC World website live
          o ►  February (1)
                + New Currys website live

    * ►  2009 (74)
          o ►  December (2)
                + Kindle DRM broken
                + La vie à l'IT :)
          o ►  November (2)
                + Oracle webcast on Digiplug
                + Scrum @ Pixmania
          o ►  July (3)
                + Pixmania recrute
                + VLC 1.0 released
                + Lipdup @ Pixmania
          o ►  June (3)
                + RIP Analog TV (1928-2009)
                + Amazon MP3 downloads available in France
                + EPIC WIN ! HADOPI law declared unconstitutional
          o ►  May (2)
                + HADOPI wars : the board is set, the pieces are mov...
                + May 1st demonstration in Paris against the HADOPI ...
          o ►  April (10)
                + Demonstration in Paris against the HADOPI law
                + WTF? Pirate Bay judge in bed with the media indust...
                + Global 2008 music sales: here comes the pain again...
                + Amendment 138 just won't die
                + P2P users buy 10 times more music
                + Some you win, some you lose
                + Three-strike policy rejected by French Parliament
                + Variable pricing: no DRM, higher prices
                + HOWTO: compiling VLC 0.9.9 + live555 + all major c...
                + Amazon MP3 store available in Germany
          o ►  March (23)
                + Google: free, legal music downloads in China (huh?...
                + "Because it’s only fair not to pay for something y...
                + Internet access 'equivalent to schooling', EU Parl...
                + Does Metallica need a record label? Ulrich says 'n...
                + Clouds, clouds, clouds
                + Three-strike policy bites the dust in NZ!
                + Vodafone, Saturn dump DRM
                + Has the battle begun?
                + http://metallica.guitarhero.com
                + Artists strike back (not what you think!)
                + It's official: French Minister of Culture has lost...
                + iTunes gift cards hacked
                + ffmpeg 0.5 released
                + U.S. cybersecurity czar resigns, blames NSA
                + OMG, your neighbor is a pirate (and so are you)
                + Adobe e-book DRM broken
                + Brick-and-mortar music retailers are dying. Fast.
                + Pirate Bay trial: the defense speaks
          o ►  February (10)
          o ►  January (19)

    * ▼  2008 (84)
          o ▼  December (25)
                + HOWTO: adding Last.fm scrobbling to mediatomb
                + HOWTO: quick reference on audio & video encoding w...
                + HOWTO: setting up a VOD server with VLC
                + Mediatomb 0.12 on PS3: video thumbnails, YouTube a...
                + VirtualBox 2.1.0 released, with much better networ...
                + HOWTO: compiling mediatomb + ffmpegthumbnailer + a...
                + HOWTO: installing gmake, gcc, svn and git on OpenS...
                + HOWTO: compiling VLC + live555 + all major codecs ...
                + YouTube, Universal & Warner: the good, the bad and...
                + HOWTO: compiling ffmpeg + x264 + MP3 + Xvid + AMR ...
                + 'Guitar Hero: Metallica' official trailer
                + HOWTO: installing VirtualBox guest additions on Ce...
                + OWASP: Security Testing Guide v3 available
                + A UNIX bi(bli)ography... and then some (subtitled:...
                + HOWTO: installing a Gnome desktop on Nexenta 1.0.1...
                + HOWTO: installing OpenOffice 3.0 on OpenSolaris 20...
                + Press release: Digiplug selects Isilon for its dig...
                + New OpenSolaris release
                + Nmap book by Gordon “Fyodor” Lyon
                + Digiplug recrute !
                + Conference slides : Spring 3.0 & mySQL
                + Pirates of the Amazon. You must see this...
                + Amazon UK launches MP3 store
                + Amendment 138 removed by EU Telecom Council
                + Market shares of Internet devices & browsers
          o ►  November (18)
          o ►  October (17)
          o ►  September (23)
          o ►  January (1)

    * ►  2007 (34)
          o ►  December (1)
          o ►  May (33)

Blog tags

    * 138
    * 3strikes
    * bikes
    * books
    * business
    * core java
    * criteo
    * database
    * digiplug
    * drm
    * ffmpeg
    * games
    * hosting
    * howto
    * javaone
    * jboss
    * linkedin
    * mediatomb
    * network
    * open source
    * owasp
    * p2p
    * performance
    * persistence
    * pixmania
    * privacy
    * ria
    * scalability
    * scrum
    * security
    * soa
    * songs
    * spring
    * storage
    * transcoding
    * unix
    * virtualization
    * vlc
    * x264
    * zfs

My Delicious Bookmarks

    * 68k Macintosh Liberation Army Forums / apple vintage
    * Vintage Computer Collection / vintage

      This web site is dedicated to collecting, restoring and simply playing with old (A.K.A. vintage, classic, antique, outdated or just plain junk) computers.
    * Full of Macintosh SE/30 / apple vintage
    * Site Apple Collection (Apple II, Lisa, Macintosh ...) / vintage apple
    * Complete List of Behavioral Interview Questions / business

      Behavioral Interviewing, a style of interviewing that is increasing in popularity due to its effectiveness, can be an intimidating activity. We have assembled an exhaustive list of sample behavioral interview questions. This guide is intended to help job seekers and interviewers alike in their preparation for their upcoming interview.

 

