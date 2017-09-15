
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything

source ./setenv



[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
export VICTOR_MDG_HOME=/home/vhuang/_under_AM_cloned_vhuang/vhuang/_src
export VICTOR_CPP_INC=/usr/include/c++/4.4
#export VICTOR_CPP_INC=/usr/lib/gcc/x86_64-linux-gnu/4.4.1/include
#export VICTOR_CPP_INC=/home/vhuang/_under_AM_cloned_vhuang/vhuang/_src/src200504_office/2005/STLport/stlport/
unset QTDIR
export QTDIR=/home/vhuang/src/qt-everywhere-opensource-src-4.8.4   
#~/src/qt-everywhere-opensource-src-4.8.4
#'/sda1/vhuang/src/qt-everywhere-opensource-src-4.7.1' 
#export JAVA_HOME=/usr/lib/jvm/java-6-openjdk
export JAVA_HOME=/usr/lib/jvm/java-6-openjdk-amd64
export ECL_DIR=/home/vhuang/bin/downloads/eclipse
unset DROID
export DROID=~/adt-bundle-linux/eclipse:~/adt-bundle-linux/sdk/tools:~/adt-bundle-linux/sdk/platform-tools:~/android-ndk-r8e  

export PATH=${DROID}:${HOME}/bin:${QTDIR}/bin:${JAVA_HOME}/bin:${ECL_DIR}:/usr/bin:/usr/local/bin:${PATH}:/sda354T/bin:/sda354T/bin/p4v-2009.2.236331/bin:/sda354T/bin/p4v-2009.2.236331:/home/vhuang/bin/android_sdk/android-sdk-linux_x86/tools:/home/vhuang/.gem/ruby/1.8/bin:~/qtcreator-2.7.0/bin:
export LD_LIBRARY_PATH=${HOME}/lib:${QTDIR}/lib:${JAVA_HOME}/lib:/usr/lib:/usr/local/lib:${LD_LIBRARY_PATH}:/sda354T/bin/p4v-2009.2.236331/lib:${ANDROID_DIR}/lib 

export LANGUAGE=en_GB
export PAGER=less
#export DISPLAY=:2

export SBDIR=/scratchbox/users/vhuang/home/vhuang
export VSRC=/scratchbox/users/vhuang/home/vhuang/src

export PATH=~/Qt/Tools/QtCreator/bin:$PATH:/home/usr/bin:/home/usr/local/bin:~/apps/node-v0.10.15-linux-x64/bin:
export LD_LIBRARY_PATH=~/home/lib:/home/usr/lib:/home/usr/local/lib:$LD_LIBRARY_PATH:~/apps/node-v0.10.15-linux-x64/lib


export Xtightvnc=/sda5/vhuang/src/cisco/libvncserver/tightvnc-1.3.9







