echo " Step 0: Prerequisites.
Code:
"

sudo apt-get -y install debootstrap binfmt-support qemu-user-static

echo "My system already had them from previous experimentation, there could be more needed.

Step 1: Prepare the chroot.
Code:
"

sudo debootstrap --foreign --arch=armel --variant=minbase \
lenny lenny-maemo-sdk-armel htt\
p://archive.debian.org/debian/

sudo cp /usr/bin/qemu-arm-static lenny-maemo-sdk-armel/usr/bin

sudo chroot lenny-maemo-sdk-armel

echo "exit 101" >/usr/sbin/policy-rc.d

chmod -v 755 /usr/sbin/policy-rc.d

echo 'APT { Install-Recommends "false"; };' > /etc/apt/apt.conf.d/no-recommends

/debootstrap/debootstrap --second-stage

mkdir -v /home/opt

useradd -m user

mkdir -pv /scratchbox/etc

touch /scratchbox/etc/scratchbox-version

ln -sv ../usr /scratchbox/tools

echo "Package: *
Pin: origin repository.maemo.org
Pin-Priority: 2000
" >/etc/apt/preferences

echo "deb htt\
p://repository.maemo.org/ fremantle/tools free non-free
deb htt\
p://repository.maemo.org/ fremantle/sdk free non-free
deb-src htt\
p://repository.maemo.org/ fremantle/sdk free non-free
deb htt\
p://repository.maemo.org/ fremantle/4bc37c7c77ebe90177\
c050b805a8dc79 nokia-binaries" >/etc/apt/sources.list

exit

echo "

Step 2: Install the SDK.
Code:
"
sudo chroot lenny-maemo-sdk-armel

apt-get update

apt-get upgrade # all yes, except resolv.conf

apt-get install libc6 # 'Yes, do as I say!'

apt-get remove sysv-rc

rm -fv /usr/sbin/update-rc.d                                                    

touch /usr/sbin/update-rc.d                                                     

chmod -v 755 /usr/sbin/update-rc.d                                              

apt-get install mini-rc

apt-get install maemo-sdk-dev bsdutils coreutils \
debianutils mktemp diff findutils grep gzip mount \
sed sysvinit-utils tar

umount -v /opt

mv -v /opt/* /home/opt/

rmdir-v /opt

ln -sv home/opt /

# we're done already, the rest is just for showing off

apt-get build-dep maemopad

cd /tmp

apt-get source maemopad

cd maemopad-2.6


echo "Note that apt-get will complain about a lot of things, just go along with everything except the overwriting of resolv.conf, unless you have a dns-server running on localhost, then it should be fine too.
"
read readline
dpkg-buildpackage -b
echo "The maemopad that was produced in the end, installed without so much as a warning on my n900, and ran just fine.

PS. The resulting lenny-maemo-sdk-armel directory occupied about 509Meg on my system. So you'll need at least that much space, afterwards about 137Meg could be recovered with an apt-get clean.
Last edited by Zaerc; 03-12-2013 at 03:43 AM.
 

    Quote & Reply |


The Following 4 Users Say Thank You to Zaerc For This Useful Post:
freemangordon, reinob, Sourav.dubey, szopin  "

