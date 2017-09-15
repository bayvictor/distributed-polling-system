
cd /hathor-*

wget http://scratchbox.org/debian/dists/stable/main/binary-i386/scratchbox-core_1.0.24_i386.deb
dpkg -i scratchbox-core_1.0.24_i386.deb

wget http://scratchbox.org/debian/dists/stable/main/binary-i386/scratchbox-devkit-debian-squeeze_1.0.7_i386.deb
wget http://scratchbox.org/debian/dists/stable/main/binary-i386/scratchbox-devkit-apt-https_1.0.11_i386.deb
wget http://scratchbox.org/debian/dists/stable/main/binary-i386/scratchbox-devkit-autotools-legacy_1.0_i386.deb
wget http://scratchbox.org/debian/dists/stable/main/binary-i386/scratchbox-devkit-debian-squeeze_1.0.7_i386.deb
wget http://scratchbox.org/debian/dists/stable/main/binary-i386/scratchbox-devkit-debian_1.0.12_i386.deb
wget http://scratchbox.org/debian/dists/stable/main/binary-i386/scratchbox-devkit-doctools_1.0.15_i386.deb
wget http://scratchbox.org/debian/dists/stable/main/binary-i386/scratchbox-devkit-git_1.0.2_i386.deb
wget http://scratchbox.org/debian/dists/stable/main/binary-i386/scratchbox-devkit-mtd_1.0.3_i386.deb
wget http://scratchbox.org/debian/dists/stable/main/binary-i386/scratchbox-devkit-perl_1.0.5_i386.deb
wget http://scratchbox.org/debian/dists/stable/main/binary-i386/scratchbox-devkit-python-legacy_1.0.2_i386.deb
wget http://scratchbox.org/debian/dists/stable/main/binary-i386/scratchbox-devkit-qemu_0.12.50-0sb3_i386.deb
wget http://scratchbox.org/debian/dists/stable/main/binary-i386/scratchbox-toolchain-arm-linux-cs2010q1-202_1.0.17-2_i386.deb

ls *.deb | sed 's/^/dpkg -i /g' > ins_all_deb.sh
chmod +x *.sh
echo "^c to break, anykey to ins all debs ..."
read readline

./ins_all_deb.sh

