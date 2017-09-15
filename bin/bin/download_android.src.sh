#!/bin/bash
LOG_FILE=tmp.output.log
SVR_LOG=~/log.reposync.log
SYNC_DATE=`date "+%Y%m%d"`
 
#rm -rf android-*
make_latest_link ()
{
        VER=$@
        ln -sf android-$SYNC_DATE-$VER.tar.bz2 latest-android-$VER.tar.bz2
        echo "ln -sf android-$SYNC_DATE-$VER.tar.bz2 latest-android-$VER.tar.bz2" >> $SVR_LOG 2>&1
        rsync -l latest-android-$VER.tar.bz2 d.zhu.im:/d/android/
        echo "uploaded latest symbol link by rsync" >> $SVR_LOG 2>&1
}
 
f_check_log_err ()
{
        ERR_NUM=$(grep -c 'error' $LOG_FILE)
        if [ "$ERR_NUM" -ne "0" ];
        then
                echo "Some Error occurred ERR_NUM=$ERR_NUM." >> $SVR_LOG 2>&1
                tail -10 tmp.output.log >> $SVR_LOG 2>&1
                echo "rm current folder" >> $SVR_LOG 2>&1
                cd ..
                rm -rf $FOLDER_NAME
                echo "quit in false" >> $SVR_LOG 2>&1
                exit 0
        else
                echo "check tmp log PASS" >> $SVR_LOG 2>&1
        fi
}
 
upload_new_android ()
{
        VERSION=$@
        FOLDER_NAME=android-$SYNC_DATE-$VERSION
        RUN_SH_DATE=`date "+%Y%m%d%H%M%S"`
        echo "Sync start date and time: $RUN_SH_DATE" >> $SVR_LOG 2>&1
        echo "Working Repo version is $VERSION" >> $SVR_LOG 2>&1
        mkdir $FOLDER_NAME
        echo "mkdir $FOLDER_NAME" >> $SVR_LOG 2>&1
        cd $FOLDER_NAME
        echo "repo init start" >> $SVR_LOG 2>&1
        repo init -u https://android.googlesource.com/platform/manifest -b android-$VERSION >> $LOG_FILE 2>&1
        f_check_log_err >> $SVR_LOG 2>&1
        echo "repo sync start" >> $SVR_LOG 2>&1
        repo sync >> $LOG_FILE 2>&1
        f_check_log_err >> $SVR_LOG 2>&1
        cd ..
        echo "tar start" >> $SVR_LOG 2>&1
        tar cjf $FOLDER_NAME.tar.bz2 $FOLDER_NAME >> $SVR_LOG 2>&1
        echo "md5sum start" >> $SVR_LOG 2>&1
        md5sum $FOLDER_NAME.tar.bz2 > $FOLDER_NAME.tar.bz2.md5.txt
        echo "sha1sum start" >> $SVR_LOG 2>&1
        sha1sum $FOLDER_NAME.tar.bz2 > $FOLDER_NAME.tar.bz2.sha1.txt
        echo "upload start" >> $SVR_LOG 2>&1
        scp $FOLDER_NAME.tar.bz2* d.zhu.im:/d/android/ >> $SVR_LOG 2>&1
        #make latest symbol link and upload by rsync -l
        make_latest_link $VERSION
        echo "rm -rf $FOLDER_NAME" >> $SVR_LOG 2>&1
        rm -rf $FOLDER_NAME*
        RUN_SH_DATE=`date "+%Y%m%d%H%M%S"`
        echo "finished ALL at time: $RUN_SH_DATE" >> $SVR_LOG 2>&1
}
 
echo "upload_new_android 2.2.2_r1
upload_new_android 2.3_r1
upload_new_android 2.3.7_r1

"





