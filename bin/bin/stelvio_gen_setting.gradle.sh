# tree -d -L 1|cut -d" " -f2|sed "s|^|include \':|g;s|$|\'|g"

 tree -d -L 1|cut -d" " -f2|sed "s|^|include \':|g;s|$|\'|g" > settings.gradle





