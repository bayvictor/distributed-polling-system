echo "usage: $0 <not_found_mes_filename> <outfn>"
echo ""
echo "   e.g.: one typical line of file \"$1\" is \"No package 'folks-telepathy' found \""
echo ""

echo "^C to break, anykey to continue...to get all no-found package  via apt-cache to install"

read readline

cat $1 | cut -d"'" -f2 | sed 's/^/apt-cache search /g' > apt_cache_search_script.sh
chmod +x *.sh
LOGfn="$2.log."`timestamp`".sh"


./apt_cache_search_script.sh | grep -e "\-dev\s" | sed 's/^/sudo apt-get install -y /g;s/ - / #- /g;s/$/\";/g' > $LOGfn

echo "^c to break, any otherkey to vi the log"
read readline

vi $LOGfn 

echo "^C to break, anykey to continue..."
read readline


chmod +x *.sh


./$LOGfn

