find |grep -e debug\.apk$|sed 's/^/adb install -r /g' >adb_ins_all.sh
chmod +x *.sh
./adb_ins_all.sh


