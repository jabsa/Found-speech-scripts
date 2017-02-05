#!/bin/bash
#wavname=/home/pbaljeka/TED-experiments/TEDLIUM_release2/train/wav_full/LesleyHazleton_2010X.wav
#transname=/home/pbaljeka/TED-experiments/TEDLIUM_release2/train/stm/LesleyHazleton_2010X_smal.stm
##expects the wav full path 
wavname=${1}
transname=`echo $wavname|sed 's+wav_full+stm+g'|sed 's+wav+stm+g'`
rm -f tmp_tdd
touch tmp_tdd
while read line;
do
speaker=`echo $line|awk '{print $1}'`
text=`echo $line|awk 'BEGIN {FS=">"} // {print $2}'|sed 's+^ ++g'`
start_time=`echo $line|awk '{print $4}'`
end_delta_time=`echo $line|awk '{print $5 - $4}'`
filename=${speaker}_${start_time}_${end_delta_time}
newavename=${wavname%/*/*}/wav_split/${filename}.wav
sox $wavname $newavename trim $start_time $end_delta_time
echo "( $filename \"$text\" )">>tmp_tdd
done <$transname
TRANSFILE=${wavname%/*/*}/etc/tdd.${speaker}
mv tmp_tdd $TRANSFILE

#make list
#sox trim


