#!/bin/bash
SPH2PIPDIR=/home/pbaljeka/TED-experiments/sph2pipe_v2.5
DATA_DIR=/home/pbaljeka/TED-experiments/TEDLIUM_release2
SPH_DIR=${DATA_DIR}/train/sph
FULL_WAV_DIR=`echo ${SPH_DIR}|sed 's+sph+wav_full+g'`
SPLIT_WAV_DIR=`echo ${SPH_DIR}|sed 's+sph+wav_split+g'`
TRANS_DIR=`echo ${SPH_DIR}|sed 's+sph+stm+g'`

mkdir -p ${FULL_WAV_DIR} ${SPLIT_WAV_DIR}

speaker_list=${DATA_DIR}/low_speakers
#Convert to wav
#Get start and end times
#Split and save with times



for speaker in `cat $speaker_list`;
do
echo $speaker
$SPH2PIPDIR/sph2pipe -p -c 1 $SPH_DIR/${speaker}.sph ${FULL_WAV_DIR}/${speaker}.wav
./split_wav_make_trans.sh ${FULL_WAV_DIR}/${speaker}.wav
done
