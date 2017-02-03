#!/bin/bash
#This takes as input the list of files.
AGELIST=$1
DEST_DIR=$2
WAV_DIR=/home/pbaljeka/Thesis/Data/English/5.CallHome/data/new_chunked_wavs
TDD=txt.done.data.clean
mkdir -p $DEST_DIR/etc $DEST_DIR/wav
#This script sets up the voice directory stuff. So basically copying the relevant chunked wav files, getting the right lines from tdd and get the small list from these lists

cat $AGELIST |awk 'BEGIN { FS = "," };{print $1}'|sed '/^$/d'|sed 's+^+en_+g'>tmp.list
grep -f tmp.list tdd|sed 's+callhome_++g'>$DEST_DIR/etc/txt.done.data
cat $DEST_DIR/etc/txt.done.data |awk '{print $2}'>tmp1.list
for i in `cat tmp1.list`;
do
echo $i
#cp $WAV_DIR/$i*.wav $DEST_DIR/recording/ 2>/dev/null || : #supress error message
cp $WAV_DIR/$i*.wav $DEST_DIR/wav/ #supress error message
done
rm tmp1.list tmp.list
