find|grep -e "\.java$" | cut -d"/" -f2|cut -d"." -f1|sed 's/^/\t\<activity android\:name=\"\./g;s/$/\"\>/g;s/$/ \n\tandroid\:label=\"@string\/app_name\"\n\t\<\/activity> /g'

