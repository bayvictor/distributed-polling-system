for f in *.flac , *.m4a , *.ogg ; do ffmpeg -i "$f" -ab 320k "${f%.m4a}.mp3"; done

