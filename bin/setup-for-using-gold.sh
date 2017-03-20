mkdir binutils
cd binutils
## below cvs checkout is frozen, we have to use the new one!
cvs -z 9 -d :pserver:anoncvs@sourceware.org:/cvs/src login
echo 'only needed the first time; enter "anoncvs" as the password), press any key when read, ^c to break'
cvs -z 9 -d :pserver:anoncvs@sourceware.org:/cvs/src co binutils
cd src
./configure  --enable-gold  --host= arm-linux-gnueabi
make -i
cd ..
ln -s src/gold/ld-new ld
apt-get install -y subversion
apt-get -f install
dpkg -i --force-overwrite /var/cache/apt/archives/libxml2_2.6.32.dfsg-5+lenny3_armel.deb
apt-get -f install


