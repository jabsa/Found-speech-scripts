#!/bin/bash

TRANS_DIR=/home2/pbaljeka/WSJ-experiments/Data/wsj_journalist/13_34_1/WSJ1/TRANS/WSJ1/SI_TR
speaker_list=/home2/pbaljeka/WSJ-experiments/Data/wsj_journalist/ca_female_JTR
DEST_DIR=/home2/pbaljeka/WSJ-experiments/Data/WSJ_JTR_CA_F/etc_LSN_NEW
rm -rf $DEST_DIR
mkdir -p $DEST_DIR

for dir in `echo J JD`;
do
for speaker in `cat ${speaker_list}`;
do
    SPKR_DIR=${TRANS_DIR}_${dir}/$speaker
    find $SPKR_DIR/* -name "*.LSN" >temp_list

    for tdd in `cat temp_list`; do
       echo $tdd
        tddname=`basename $tdd .LSN`
        cat $tdd|sed '/\*/d'|sed 's+(PARENTHESES++g'|sed 's/)CLOSE-PARENTHESES//g'|sed 's+(PAREN++g'|sed 's+)PAREN++g'|sed 's/(IN-PAREN//g'|sed 's/)END-OF-PAREN//g'|sed 's/~NEW-GRAPH//g'|sed 's/~NEW-STORY//g'|sed 's/~END-OF-STORY//g'|sed 's/~NEW-TITLE//g'|sed 's/~TITLE//g'|sed 's/~NEW-PARAGRAPH//g'|sed 's/~IN-ITALICS//g'|sed 's/~NEW-[A-Z]*//g'|sed 's/~[*,A-Z].* //g'|sed 's/CLOSE-[A-Z]*//g'|sed 's/-EM/EM/g'>temp_tdd.temp
       #cat $tdd>temp_tdd.temp
        cat temp_tdd.temp|awk 'BEGIN { FS="(" } // {print $2}'|sed 's+^+( JTR_+g'|sed 's+)++g'>temp_names
        cat temp_tdd.temp|awk 'BEGIN { FS="(" } // {print $1}'|tr '[:upper:]' '[:lower:]'|sed 's+^+\"+g'|sed 's+ $+" )+g' |sed 's+,comma+,+g' |sed 's+\.period+\.+g'|sed 's+\"open-quotes++g'|sed 's+\"close-double-quotes++g'|sed 's+\"quote++g'|sed 's+\"end-quote++g'| sed 's/-dash/-/g'|sed 's+\"close-quotes++g'|sed 's+close-single-quote++g' |sed 's+close-quote++g'|sed 's+\"close-single-quote++g'|sed 's+;semi-colon+;+g'|sed 's+:colon+:+g'|sed 's+?question-mark+?+g'|sed 's+  + +g'|sed 's+ \.+\.+g'|sed 's+ ,+,+g'|sed 's+ ?+?+g'|sed 's+ ;+;+g'|sed 's/ -/-/g'|sed 's+ :+:+g'>temp_text
        paste -d " " temp_names temp_text >${DEST_DIR}/tdd.${tddname}

    done
    rm -f temp_*
done
done

mkdir ${DEST_DIR}/Spontaneous
mkdir ${DEST_DIR}/Read
mkdir ${DEST_DIR}/Common

mv ${DEST_DIR}/tdd.44[A-Z]A* ${DEST_DIR}/Read
mv ${DEST_DIR}/tdd.44[A-Z]C* ${DEST_DIR}/Common
mv ${DEST_DIR}/tdd.44[A-Z]S* ${DEST_DIR}/Spontaneous


cat ${DEST_DIR}/Read/tdd.* >${DEST_DIR}/Read/txt.done.data.read
cat ${DEST_DIR}/Common/tdd.* >${DEST_DIR}/Common/txt.done.data.common
cat ${DEST_DIR}/Spontaneous/tdd.* >${DEST_DIR}/Spontaneous/txt.done.data.spon


