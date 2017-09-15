# !/bin/bash

#quote to search for in html post-login file login.do when checking password at login time
strq1="incorrect"

#this is the url and postfield names to use for searching entries, <i> is replaced with emails from cicq's contact list
strq2="hi5.com/friend/processNameSearch2.do?text=<i>&type=1&searchNew=1"

#file in hi5 default path where username and password for your hi5 login (needed in order to search for friends) will be stored, it is chmodded 700.
accfile=".account"

#default dir to store settings and files for hi5
fivedir=~/.hi5

#centericq installation dir
cicqdir=~/.centericq

#default temp dir to store downloaded html files before processing
tmpdir=$fivedir/tmp

#mates file
mfile=mates

#width of bar max is i.e. 40chars, half og 80 cols terminal
blen=40

#spacing in chars between ] and i% when showing the bar, 3 is default
pctspac=3

#tput vars
lastpct=0
lastline=14

#has to be integer or the script will fail
slpsecs=1

entries=`ls -alh ''$cicqdir''|cut -d" " -f11|cut -c2-|grep @|wc -l`
todl=`expr $entries \* 22`
dltime=`echo $todl/480|bc`
dltime="`expr $dltime+4|bc`"	#bc roundup bug? doesnt round up on val>x.5

clear; echo -e "Scanning for hi5 profiles using centericq path: $cicqdir. 
Please be paitient as this could take a few minutes with dial-up \
connection.\nFound $entries contacts in your \
centericq dir to scan. \n\
Around $todl kB to download.\n\
Estimated download time is $dltime \
minutes with an ISDN 64kBbit connection."

aneta=0
aleta=1

bar() {

	local chars=`echo $1*$blen/100|bc`
	local s=`expr $blen - $chars`
	local d=`expr $s - 1`
	local c=0

	tput civis; tput rc

        if [ `echo $3|wc -c` > 1 ]; then
		echo -n "`date -d "1970-01-01 $3 sec" +%M:%S` ["
	else
		echo -n "["
	fi

	if [ $1 > 0 ]; then

        	 while [  $c -le $chars ]; do
	             echo -n "="
        	     let c+=1 
	         done
	fi;c=0

	if [ ! $drawed ]; then

		while [ $c -le $d ]; do
			echo -n "-"
			let c+=1
		done
		drawed=1

	else
		tput cuf $s
	fi

	echo -n "]";tput cuf $pctspac;echo -n "$1% "

	tput cnorm

#experimental eta code
#	if [ `echo $3|wc -c` > 1 ]; then
#		bspct=$1;btodl=$2;bdtime=$3
#
#			aneta="`echo '('$btodl' * '$bdtime' * 100) / ('$bspct' * '$btodl')'|bc`"
#
#
#			if [ "$aleta" -gt "$aneta" ]; then
#				echo -e "\n\aleta: $aleta   >    aneta: $aneta\n\n"
#				echo -e "\nETA: $aneta sec(s)."
#			fi
#
#			aleta="$aneta"
#
#
#	fi

}

rmo() {
	$*&>/dev/null
}


rmo "rm -rf $fivedir/*"
rmo "mkdir $fivedir"
rmo "mkdir $tmpdir"
rmo "cd $fivedir"

for i in $(ls -alh ''$cicqdir''|cut -d" " -f11|cut -c2-|grep @); do a="$a `echo $strq2|sed -e "s/<i>/$i/"`"; done; q=0

if [ ! -f "$accfile" ]; then
	q=1
	echo -n "Enter username for hi5 login (email): ";	read user
	echo -n "Enter password for account: "; 		stty -echo; read pass; stty echo

else

	user=`cut -d":" -f1 $accfile`
	pass=`cut -d":" -f2 $accfile`

fi

echo -e "\n-\nTesting username and password for hi5 login.. Please wait.."

#wget -qO .login_log --post-data email\=''$user''\&password\=''$pass'' hi5.com/friend/login.do
wget -qO "`norm.sh $user_log`" --post-data email\=''$user''\&password\=''$pass'' hi5.com

if [ -n "`grep ''$strq1'' .login_log`" ]
then

	rmo "rm $accfile .login_log"
	echo "Wrong username/password supplied, exiting and deleting stored account information."
	exit

else
	if [ -n q ]; then 

		echo "$user:$pass">$accfile
		echo -e "\nUsername and password were saved to $fivedir/$accfile for\nfuture use, and directory was chmodded 700 for security."

	fi

	echo -e "Account verified. Proceeding..\nCommunicating.. This could take a few minutes..\n"

fi



rmo "chmod 700 $fivedir -R"

cd $tmpdir

wget -q --post-data email\=''$user''\&password\=''$pass''  hi5.com ''$a''&
#wget -q --post-data email\=''$user''\&password\=''$pass''  hi5.com/friend/login.do ''$a''&

tput sc
status=`ls .|wc -l`
dtime=0
lastpct=0

while [ $status -le  $entries ]; do
	spct=`echo $status*100/$entries|bc -l|cut -d"." -f1`

	if [ $spct != $lastpct ]; then

		if [ $lastpct > 2 ]; then

			bar $spct $todl $dtime

		else
			bar $spct
		fi


	fi


	lastpct=$spct
	sleep $slpsecs

	let dtime=$dtime+$slpsecs

	status=`ls .|wc -l`

done; tput rc


echo -e "The following user(s) in your centericq contact list is/are on hi5:"
echo "----------------------------------------------"

for i in `ls | grep @`
do

	a2=`ls $i | cut -d"=" -f2 | cut -d"&" -f1`
	mv $i $a2&>/dev/null

	if [ -n "$(grep "username_dark" $a2)" ]; then
		echo -e "$a2 \t|\t $(grep "username_dark" "$a2"|cut -d ">" -f2|cut -d"<" -f1)"
		adrs="$adrs $a2"
	fi
		echo $adrs>$fivedir/$mfile
done

echo "-----------------------------------------------"

echo -e "\nThis list was saved to $fivedir/$mfile in a copy-friendly version."

exit 0

