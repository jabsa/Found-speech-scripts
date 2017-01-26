#!/bin/bash

#Convert Librispeech corpus to Festival Format
LIBRI_SPEECH_DIR=$1
#Subset = train-clean-100 train-clean-360 train-other-500
SUBSET=$2 
SCRIPT_DIR=`pwd`/Librispeech-scripts

##Get male female subsets
$SCRIPT_DIR/get_male_female_subsets.sh $LIBRI_SPEECH_DIR $SUBSET

##Convert all flac files to mp3  and make tdd
for gender in `echo "male" "female"`; do
    echo "Converting flac files to wavs for all ${gender}s"
    ID_LIST=$LIBRI_SPEECH_DIR/$SUBSET-${gender}_speaker_ids
    DEST_DIR_WAV=$LIBRI_SPEECH_DIR/$SUBSET/${SUBSET}_${gender}_wavs
    DEST_DIR_TXT=$LIBRI_SPEECH_DIR/$SUBSET/${SUBSET}_${gender}_txt
    $SCRIPT_DIR/make_wavs.sh $LIBRI_SPEECH_DIR $SUBSET $ID_LIST $DEST_DIR_WAV
    $SCRIPT_DIR/make_tdd.sh $LIBRI_SPEECH_DIR $SUBSET $ID_LIST $DEST_DIR_TXT
done

echo "gender specific subset of wav and txt directories created in " $LIBRI_SPEECH_DIR/$SUBSET/
