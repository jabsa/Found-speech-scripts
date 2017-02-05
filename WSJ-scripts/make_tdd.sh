#!/bin/bash

TRANS_DIR=/home2/pbaljeka/WSJ-experiments/Data/wsj_journalist/13_34_1/WSJ1/TRANS/WSJ1/SI_TR_J/
speaker_list=/home2/pbaljeka/WSJ-experiments/Data/wsj_journalist/JTR_female_Speakers
DEST_DIR=/home2/pbaljeka/WSJ-experiments/Data/WSJ_JTR_CA_F/etc
for speaker in `cat ${speaker_list}`;
do
    SPKR_DIR=${TRANS_DIR}/$speaker
    find $SPKR_DIR/* -name "*.PTX" >temp_list

    for tdd in `cat temp_list`; do
       echo $tdd
        tddname=`basename $tdd .PTX`
        cat $tdd|awk 'BEGIN { FS="(" } // {print $2}'|tr '[:lower:]' '[:upper:]'|awk '{print $1}'|sed 's+^+( JTR_+g'>temp_names
        cat $tdd|awk 'BEGIN { FS="(" } // {print $1}'|sed 's+"++g'|sed 's+^+"+g'|sed 's+ $+" )+g' >temp_text
        paste -d " " temp_names temp_text >${DEST_DIR}/tdd.${tddname}

    done
    rm -f temp_*
done

