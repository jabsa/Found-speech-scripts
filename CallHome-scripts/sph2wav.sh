#!/bin/bash
SOURCE_DIR=/home2/pbaljeka/Thesis2016/found_voices/5.CallHome/data/wav/evltest 
DEST_DIR=/home2/pbaljeka/Thesis2016/found_voices/5.CallHome/data/wav/evltest_wav
SPH2PIPDIR=/home2/pbaljeka/Thesis2016/found_voices/5.CallHome/temp/sph2pipe_v2.5

for i in $SOURCE_DIR/*.sph;
do
file=`basename $i .sph`
echo "Processing ${file}"
$SPH2PIPDIR/sph2pipe -p -c 1 $i $DEST_DIR/${file}.wav
done
