echo '#!/bin/sh' >/usr/bin/sbox-qmake;echo '/usr/bin/scratchbox -d $PWD qmake $@' >>/usr/bin/sbox-qmake;chmod 755 /usr/bin/sbox-qmake
echo '#!/bin/sh' >/usr/bin/sbox-make;echo '/usr/bin/scratchbox -d $PWD make $@' >>/usr/bin/sbox-make;chmod 755 /usr/bin/sbox-make

