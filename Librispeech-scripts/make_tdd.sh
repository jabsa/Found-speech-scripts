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
    cat `find $SOURCE_DIR/* -name "*.txt"`>temp_translist
    cat temp_translist|awk '{print $1}'|sed 's+^+'"$SUBSET"'+g'|sed 's+^+( +g' > temp_names
    cat temp_translist|awk '{for (i=2; i<=NF; i++) printf $i" "; printf "\n"}' |tr '[:upper:]' '[:lower:]'|sed 's+^ +\"+g'|sed 's+$+" )+g' >temp_data

    paste -d " " temp_names temp_data >$DEST_DIR/tdd.$speaker
    rm -f temp_*
done

cat $DEST_DIR/tdd* >$DEST_DIR/txt.done.data
