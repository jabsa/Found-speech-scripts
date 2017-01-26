#!/bin/bash


#Get male and female subsets and their ids
LIBRI_SPEECH_DIR=$1
SUBSET=$2
SPEAKER_FILE=${LIBRI_SPEECH_DIR}/SPEAKERS.TXT

rm -f $LIBRI_SPEECH_DIR/$SUBSET-female_speaker_ids
rm -f $LIBRI_SPEECH_DIR/$SUBSET-male_speaker_ids
# Get the Male  and Female speaker ids
cat $SPEAKER_FILE|grep "$SUBSET"|grep "| F |"|awk '{print $1}' > $LIBRI_SPEECH_DIR/$SUBSET-female_speaker_ids
cat $SPEAKER_FILE|grep "$SUBSET"|grep "| M |"|awk '{print $1}' > $LIBRI_SPEECH_DIR/$SUBSET-male_speaker_ids

NUM_FEMALE_SPEAKERS=`cat $LIBRI_SPEECH_DIR/$SUBSET-female_speaker_ids| wc -l`
NUM_MALE_SPEAKERS=`cat $LIBRI_SPEECH_DIR/$SUBSET-male_speaker_ids| wc -l`

f_dur=`cat $SPEAKER_FILE|grep "$SUBSET"|grep "| F |"|awk 'BEGIN { FS="|" } {TOTAL=TOTAL+$4} END {print TOTAL/60}'`
m_dur=`cat $SPEAKER_FILE|grep "$SUBSET"|grep "| M |"|awk 'BEGIN { FS="|"} {TOTAL=TOTAL+$4} END {print TOTAL/60}'`

echo "Number of female speakers in $SUBSET : " $NUM_FEMALE_SPEAKERS "Total Duration (HH.MM) : " $f_dur
echo "Number of male speakers in $SUBSET : " $NUM_MALE_SPEAKERS  "Total Duration (HH.MM) : " $m_dur


