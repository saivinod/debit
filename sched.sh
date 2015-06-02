#!/bin/bash
sed -i -e '/^$/d' /home/vinod/debit/ls.out
sed -i -e '/^$/d' /home/vinod/debit/lastday.out
#sed -i -e '/^$/d' /home/vinod/debit/ls.out
tail -n 1 /home/vinod/debit/ls.out > /home/vinod/debit/ldtemp1.out
while read b
do
ld="$b"
td=$(date '+%Y-%m-%d %H:%M:%S')
#td="2003-04-21 22:55:02"
#echo $td
#./datediff.sh $ld $td
 #echo $(( ( $(date -ud '2003-08-02 17:24:33' +'%s') - $(date -ud '2003-04-21 22:55:02' +'%s') )/60/60/24 )) days
#echo $(( ($(date --date="td" +%s) - $(date --date="ld" +%s) )/(60*60*24) ))
f=$(( ( $(date -ud "$td" +'%s') - $(date -ud "$ld" +'%s') )/60/60/24 ))
#date -d @$(( $(date -d "$date2" +%s) - $(date -d "$date1" +%s) )) -u +'%H:%M:%S'
#echo $f >>/home/vinod/debit/test2.out
if [[ $f -eq 1 ]]
then
c=1
else
c=$(($f-1))
fi
for ((i=0;i<$c;i++ ))
do
   . /home/vinod/debit/maincron2.sh

done
 
done</home/vinod/debit/ldtemp1.out
