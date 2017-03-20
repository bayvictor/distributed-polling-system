#for d in ~/Music/iTunes/iTunes\ Music/Music/*; \
for d in MP3denglijun/*; \
do \
  adb push "$d" "/sdcard/Music/`basename $d`"; \
done

