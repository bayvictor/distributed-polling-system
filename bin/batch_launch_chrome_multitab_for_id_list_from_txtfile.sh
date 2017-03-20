#!/bin/bash 
##!/bin/bash -x 

IDFILE=""
BROW=""
DELAY=10 
SHOWHELP=no
MASTERID="5926403371"
# Or, without "shift": use loop counter until $# ( = number of args)

ARGV0=$0 # First argument is shell command (as in C)
#echo "Command: $ARGV0"

ARGC=$#  # Number of args, not counting $0
#echo "Number of args: $ARGC"



i=1  # Used as argument index
while [ $i -le $ARGC ]; do # "-le" means "less or equal", see "man test".
	# "${!i} "expands" (resolves) to $1, $2,.. by first expanding i, and
	# using the result (1,2,3..) as a variable which is then expanded.
#	echo "Argv[$i] = ${!i}"
        arg=${!i}
        i1=$((i+1))
        arg1=${!i1}
        firstletter=${arg1:0:1}
	if [ "${firstletter}" = "-" ]; then
           echo "missing argument following option (\""$arg"\")"
           exit 1
        fi

  case $arg in
  -h | --h | --help)
    SHOWHELP=yes
    break
    ;;
  -a | --a | --all_browsers_supported)
          echo " diversified different browsers usage:"
          echo "E.g. usage:"
          echo "       $0 -i idlist.txt -b  chromium-browser -d 10"
          echo "       $0 -i idlist.txt -b  firefox -d 10"
          echo "       $0 -i idlist.txt -b  epiphany -d 10"
          echo "       $0 -i idlist.txt -b  webhttrack -d 10"
          echo "       $0 -i idlist.txt -b  rekonq  -d 10"
          echo "       $0 -i idlist.txt -b  dwb -d 10"
          echo "       $0 -i idlist.txt -b  xxxterm -d 10"
          echo "       $0 -i idlist.txt -b  dooble  -d 10"
          echo "       $0 -i idlist.txt -b  qupzilla -d 10"
          echo "       $0 -i idlist.txt -b  luakit -d 10"
          exit 0
    ;;
  -i | --i | --idfile)
     if test -z	 "${!i1}"; then
        echo "id path-filename can not be empty following \"-i\""
	    exit 1
     else 
        IDFILE="${!i1}"
 #       echo "your input IDFILE=(${IDFILE})" 
        i=$((i+1))   ## next loop
     fi
    ;;
  -b | --b | --browser)
     if test -z	 "${!i1}"; then
        echo "browser name can not be empty following \"-b\""
	    exit 1
     else 
        BROW="${!i1}"
#        echo "your input BROW=(${BROW})" 
        i=$((i+1))   ## next loop
     fi
    ;;
  -d | --d | --delay)
     if test -z	 "${!i1}"; then
#        echo "missing delay max seconds between pop-tab in browser following \"-d\""
	    exit 1
     else 
        DELAY="${!i1}"
#        echo "your input DELAY=(${DELAY})" 
        i=$((i+1))   ## next loop
     fi
    ;;
  -m | --m | --masterid)
     if test -z	 "${!i1}"; then
        echo "missing master-id following \"-m\""
	    exit 1
     else 
        MASTERID="${!i1}"
#        echo "your input MASTERID=(${MASTERID})" 
        i=$((i+1))   ## next loop
     fi
    ;;
  -*)
    echo "The command option is not recognized: $arg"
    echo "Please use the format:"
    SHOWHELP=yes
    break
    ;;

  *)
    echo "The command is not recognized: $arg"
    echo "Please use the format:"
    SHOWHELP=yes
    break
    ;;

  esac

# shift

	i=$((i+1))   ## next loop

done



if  test -z "$IDFILE" ; then
        echo "missing id_filename following \"-i\""
        SHOWHELP=yes
fi

if  test -z "$BROW" ; then
        echo "missing browser_name following \"-b\""
        SHOWHELP=yes
fi


if  test -z "$MASTERID" ; then
        echo "missing masterid following \"-m\""
        SHOWHELP=yes
fi

#echo "inputing arguments parsing Done."
#exit 0  ## testing....


# cat playsheet.txt|grep "\-"|cut -d"-" -f2|sed 's|^|http://www.hi5.com/apps/pets.html?ll=tag_profile_mod&uid=5926403371#/pet/|g;s/^/chromium-browser /g;s/$/ \&/g'

ARGV0=$0 # First argument is shell command (as in C)
#echo "Command: $ARGV0"

ARGC=$#  # Number of args, not counting $0
#echo "Number of args: $ARGC"


#cat $1 | sed 's|^|http://www.hi5.com/apps/pets.html?ll=tag_profile_mod&uid=5926403371#/pet/|g;s/^/chromium-browser /g; s|$|;sleep $[ ( $RANDOM % 30 )  + 1 ]s; |g;'



if test "$SHOWHELP" == yes; then
   echo "**********************************************************"
   echo "$0 [--h]"
   echo "               --i id_filename"
   echo "               --b browser-name"
   echo "               --m master-id"
   echo "               --a list all browsers supported"
   echo "               [--d delay]"
   echo "E.g:"
   echo "$0 -i  daysrc_id.txt.id.txt.id.txt -b chromium-browser -d 10 -m 5926403371"
   echo "" 
   echo "**********************************************************"
   exit 0
fi

cat $IDFILE |grep -e [0-9]|tr ' ' '\n'|grep -e "^[0-9]" > $IDFILE.out 
IDFILE=$IDFILE".out" 

OUT_SH=`timestamp`."$IDFILE"."$BROW".sh



echo "unset IDFILE;unset BROW; unset DELAY; unset MASTERID" > $OUT_SH
echo "export IDFILE=$IDFILE" >>$OUT_SH
echo "export BROW=$BROW"   >>$OUT_SH
echo "export DELAY=$DELAY"  >>$OUT_SH
echo "export MASTERID=$MASTERID"  >>$OUT_SH

cat $IDFILE | sed 's|^|http://www.hi5.com/apps/pets.html?dataSource=Pets&ll=nav#/pet/|g;s/^/$BROW /g; s|$|;sleep $[ ( $RANDOM % $DELAY )  + 1 ]s; |g;' >>$OUT_SH
#cat $IDFILE | sed 's|^|http://www.hi5.com/apps/pets.html?ll=tag_profile_mod&uid=$MASTERID#/pet/|g;s/^/$BROW /g; s|$|;sleep $[ ( $RANDOM % $DELAY )  + 1 ]s; |g;' >>$OUT_SH

chmod +x *.sh

cat $OUT_SH

echo "^C to break, anykey to run script (\"$OUT_SH\")";  read readline 

"./"$OUT_SH



