#!/bin/bash
DEST_DIR=/home2/pbaljeka/WSJ-experiments/Data/WSJ_JTR_CA_F/wav
SPH2PIPDIR=/home2/pbaljeka/WSJ-experiments/sph2pipe_v2.5
filelist=/home2/pbaljeka/WSJ-experiments/Data/wsj_journalist/ca_females_wavfiles
for i in `cat $filelist`;
do
file=`basename $i .WV1`
echo "Processing ${file}"
$SPH2PIPDIR/sph2pipe -p -c 1 $i $DEST_DIR/JTR_${file}.wav
done
