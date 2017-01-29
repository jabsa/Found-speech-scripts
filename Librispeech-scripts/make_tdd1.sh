#!/bin/bash
##LIBRI_SPEECH_DIR=`pwd`/LibriSpeech
##SUBSET="train-clean-100"
##SPEAKER_LIST=$LIBRI_SPEECH_DIR/temp_check_id
##DEST_DIR=$LIBRI_SPEECH_DIR/$SUBSET/temp_check

speaker=a
SUBSET=blah
   temp_translist=$1
    cat $temp_translist|awk '{print $1}'|sed 's+^+'"$SUBSET"'+g'|sed 's+^+( +g' > temp_names
    cat $temp_translist|awk '{for (i=2; i<=NF; i++) printf $i" "; printf "\n"}' |tr '[:upper:]' '[:lower:]'|sed 's+^+\"+g'|sed 's+$+" )+g' >temp_data

    paste -d " " temp_names temp_data >tdd.$speaker
