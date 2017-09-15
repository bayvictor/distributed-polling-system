   ./configure --prefix=/opt/media/local --disable-everything --disable-network --disable-swscale        \
              --disable-amd3dnow --disable-amd3dnowext --enable-shared        \
 	       --enable-libvpx                                                 \
      	       --enable-decoder=theora,vorbis,libvpx                           \
			       	       --enable-demuxer=ogg,matroska           \
		       	       --enable-memalign-hack
