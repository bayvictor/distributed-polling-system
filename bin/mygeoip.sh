#curl -s http://www.telize.com/geoip/24.4.130.79 | python -mjson.tool
#curl -s http://www.telize.com/geoip/$1 | python -mjson.tool
#or:
#wget -qO- http://www.telize.com/geoip/`wget -qO- http://ipecho.net/plain ; echo` | python -mjson.tool


curl -s http://www.telize.com/geoip/`curl ipecho.net/plain ; echo` | python -mjson.tool

# one-liner for parsing simple JSON data :
#curl -s http://www.telize.com/geoip/$1 | python -c 'import sys, json; print json.load(sys.stdin)["country"]'
#Netherlands


