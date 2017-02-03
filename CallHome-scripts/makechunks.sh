#!/bin/bash
TRANS_DIR=/home/pbaljeka/Thesis2016/found_voices/Telephone/English/IS2016/Data/5.CallHome/data/trans/evltest
WAV_DIR=/home/pbaljeka/Thesis2016/found_voices/Telephone/English/IS2016/Data/5.CallHome/data/wav/evltest_wav
min_time=$(echo "1.5" | bc)
OUT_WAV_DIR=/home/pbaljeka/Thesis2016/found_voices/Telephone/English/IS2016/Data/5.CallHome/data/wav/chunked_evltest_wavs
mkdir -p $OUT_WAV_DIR
#chunk the speech files using sox and select chunks with at least 4 words and write to tdd. 
for i in $TRANS_DIR/*.txt;
do
file=`basename $i .txt`
echo $file
cat $TRANS_DIR/${file}.txt|grep "A:"|sed 's+ +888space888+g'>temp_trans
count=0
for line in `cat temp_trans`;
do
start1=`echo $line|awk 'BEGIN { FS = "888space888" } ; { print $1 }'`
end1=`echo $line|awk 'BEGIN { FS = "888space888" } ; { print $2 }'`
dur=$(echo "$end1 - $start1" | bc)
text=`echo $line|awk 'BEGIN { FS = ":"} ; { print $2}'|sed 's+888space888+ +g'|sed 's/^[ \t]*//;s/[ \t]*$//'`
if (( $(echo "$dur > $min_time" |bc -l) ));then
sox -v 0.9 --norm  $WAV_DIR/${file}.wav  -r 16k -b 16 $OUT_WAV_DIR/${file}-$count.wav dither -s trim $start1 $dur 
echo "( ${file}-$count \"$text\")" >>tdd
count=$((count+1))
fi
done
rm temp_trans
done
#cat tdd|tr '[]' '()'|sed '/(( ))/d'|sed '/(([a-z].*))/d'|sed '/{[a-z]*}/d'|sed '/&/d'|sed 's+%++g'>txt.done.data
