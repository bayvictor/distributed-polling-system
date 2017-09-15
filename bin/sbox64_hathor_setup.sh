echo "run as root! ^c to break, any other key to continue..."
read read_line
cd /
mkdir /sda1/vhuang/src/WOW/glenn_slp_build_tools/sbox64bin
cd /sda1/vhuang/src/WOW/glenn_slp_build_tools/sbox64bin
mkdir sbox64bin
ln -s /sda1/vhuang/src/WOW/glenn_slp_build_tools/sbox64bin /scratchbox
ln -s /scratchbox /sbox64
ln -s /sbox64 /usr/local/sbox64  
chown vhuang /sbox64

echo "u r run as root! ^c to break, any other key to continue..."
read read_line
dpkg -i /home/vhuang/src/WOW/glenn_slp_build_tools/sbox-releases_hathor_deb_amd64/scratchbox-libs_1.0.22_amd64.deb --instdir=/usr/local/sbox64


dpkg -i /home/vhuang/src/WOW/glenn_slp_build_tools/sbox-releases_hathor_deb_amd64/scratchbox-core_1.0.22_amd64.deb --instdir=/usr/local/sbox64
ls /scratchbox


echo "u r run as root! ^c to break, any other key to continue..."
read read_line



dpkg -i /home/vhuang/src/WOW/glenn_slp_build_tools/sbox-releases_hathor_deb_amd64/scratchbox-toolchain-arm-linux-cs2010q1-202_1.0.17-2_amd64.deb         --instdir=/usr/local/sbox64 
echo "u r run as root! ^c to break, any other key to continue..."
read read_line
dpkg -i /home/vhuang/src/WOW/glenn_slp_build_tools/sbox-releases_hathor_deb_amd64/scratchbox-toolchain-cs2009q3-eglibc2.10-armv7-hard_1.0.19-5_amd64.deb			 --instdir=/usr/local/sbox64 
echo "u r run as root! ^c to break, any other key to continue..."
read read_line
dpkg -i /home/vhuang/src/WOW/glenn_slp_build_tools/sbox-releases_hathor_deb_amd64/scratchbox-toolchain-cs2009q1-eglibc2.8-armv7_1.0.19-11_amd64.deb					 --instdir=/usr/local/sbox64 
echo "u r run as root! ^c to break, any other key to continue..."
read read_line
dpkg -i /home/vhuang/src/WOW/glenn_slp_build_tools/sbox-releases_hathor_deb_amd64/scratchbox-toolchain-cs2009q1-eglibc2.8-armv7_1.0.18-11_amd64.deb					 --instdir=/usr/local/sbox64 
dpkg -i /home/vhuang/src/WOW/glenn_slp_build_tools/sbox-releases_hathor_deb_amd64/scratchbox-toolchain-cs2009q3-eglibc2.10-armv7-soft_1.0.19-6_amd64.deb			 --instdir=/usr/local/sbox64 
dpkg -i /home/vhuang/src/WOW/glenn_slp_build_tools/sbox-releases_hathor_deb_amd64/scratchbox-toolchain-cs2009q3-eglibc2.10-armv7-hard_1.0.19-6_amd64.deb			 --instdir=/usr/local/sbox64 
dpkg -i /home/vhuang/src/WOW/glenn_slp_build_tools/sbox-releases_hathor_deb_amd64/scratchbox-toolchain-arm-linux-cs2009q3-67_1.0.18-1_amd64.deb							 --instdir=/usr/local/sbox64 
dpkg -i /home/vhuang/src/WOW/glenn_slp_build_tools/sbox-releases_hathor_deb_amd64/scratchbox-toolchain-cs2009q3-eglibc2.10-armv7-hard_1.0.19-8_amd64.deb			 --instdir=/usr/local/sbox64 
dpkg -i /home/vhuang/src/WOW/glenn_slp_build_tools/sbox-releases_hathor_deb_amd64/scratchbox-toolchain-cs2009q3-eglibc2.10-armv7-hard_1.0.20-9_amd64.deb			 --instdir=/usr/local/sbox64 
dpkg -i /home/vhuang/src/WOW/glenn_slp_build_tools/sbox-releases_hathor_deb_amd64/scratchbox-toolchain-cs2009q3-eglibc2.10-armv7-hard_1.0.17-2_amd64.deb			 --instdir=/usr/local/sbox64 
dpkg -i /home/vhuang/src/WOW/glenn_slp_build_tools/sbox-releases_hathor_deb_amd64/scratchbox-toolchain-cs2009q3-eglibc2.10-armv7-soft_1.0.18-5_amd64.deb			 --instdir=/usr/local/sbox64 
dpkg -i /home/vhuang/src/WOW/glenn_slp_build_tools/sbox-releases_hathor_deb_amd64/scratchbox-toolchain-cs2007q3-glibc2.5-arm7_1.0.16-2_amd64.deb							 --instdir=/usr/local/sbox64 
dpkg -i /home/vhuang/src/WOW/glenn_slp_build_tools/sbox-releases_hathor_deb_amd64/scratchbox-toolchain-cs2009q3-eglibc2.10-armv7-hard_1.0.18-4_amd64.deb			 --instdir=/usr/local/sbox64 
dpkg -i /home/vhuang/src/WOW/glenn_slp_build_tools/sbox-releases_hathor_deb_amd64/scratchbox-toolchain-cs2009q3-eglibc2.10-armv7-soft_1.0.17-4_amd64.deb			 --instdir=/usr/local/sbox64 
dpkg -i /home/vhuang/src/WOW/glenn_slp_build_tools/sbox-releases_hathor_deb_amd64/scratchbox-toolchain-cs2009q3-eglibc2.10-armv7-hard_1.0.17-3_amd64.deb			 --instdir=/usr/local/sbox64 
dpkg -i /home/vhuang/src/WOW/glenn_slp_build_tools/sbox-releases_hathor_deb_amd64/scratchbox-toolchain-cs2009q3-eglibc2.10-armv7-hard_1.0.20-10_amd64.deb		 --instdir=/usr/local/sbox64 
dpkg -i /home/vhuang/src/WOW/glenn_slp_build_tools/sbox-releases_hathor_deb_amd64/scratchbox-toolchain-cs2009q1-eglibc2.8-armv7_1.0.17-10_amd64.deb					 --instdir=/usr/local/sbox64 

























