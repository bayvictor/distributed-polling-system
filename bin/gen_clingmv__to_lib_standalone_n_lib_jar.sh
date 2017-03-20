find|grep -e "\btarget\/cling[^\/]*\.jar$" | sed 's/^/cp /g;s/$/ \~\/lib /g' > go.sh;chmod +x go.sh;./go.sh
