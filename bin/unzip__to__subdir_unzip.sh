mkdir unzip;cd unzip;find .. |grep -e 'gz$'|sed 's/^/tar -zxvf /g' > unzip_all.sh
chmod +x *.sh
./unzip_all.sh
cd ..
mkdir zips

mv *gz zips








