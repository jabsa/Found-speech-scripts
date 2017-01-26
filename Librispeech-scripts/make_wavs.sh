#!/bin/bash
##LIBRI_SPEECH_DIR=`pwd`/LibriSpeech
##SUBSET="train-clean-100"
##SPEAKER_LIST=$LIBRI_SPEECH_DIR/temp_check_id
##DEST_DIR=$LIBRI_SPEECH_DIR/$SUBSET/temp_check


LIBRI_SPEECH_DIR=$1
SUBSET=$2
SPEAKER_LIST=$3
DEST_DIR=$4

mkdir -p $DEST_DIR

for speaker in `cat ${SPEAKER_LIST}`; do
    echo "Processing speaker_id : $speaker"
    SOURCE_DIR=$LIBRI_SPEECH_DIR/$SUBSET/$speaker
    find $SOURCE_DIR/* -name "*.flac">temp_filelist
    for file in `cat temp_filelist`; do
        dest_file=`basename $file`
        echo "Converting $dest_file"
        sox $file $DEST_DIR/${SUBSET}_${dest_file%.flac}.wav; 
    done
    rm -f temp_filelist
done
