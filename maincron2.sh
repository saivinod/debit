#date +%Y-%m-%d >> /home/vinod/debit/date1.out
#date +%d-%m-%Y >>/home/vinod/debit/date2.out
#date -d '1 day ago' +'%Y-%m-%d'> /home/vinod/debit/date1.out
#date -d '1 day ago' +'%d-%m-%Y'>/home/vinod/debit/date2.out


#sed -i -e '/^$/d' date1.out
#sed -i -e '/^$/d' date2.out

#while read h
#do
#d=$h

#done</home/vinod/debit/date1.out

#while read q
#do
#d2=$q

#done</home/vinod/debit/date2.out

#rm /home/vinod/debit/date1.out
#rm /home/vinod/debit/date2.out

#d=$1;
#d2=$2;
#mkdir $2;
tail -n 1 /home/vinod/debit/lastday.out >>/home/vinod/debit/ldtemp.out

while read a
do
d=$(date '+%Y-%m-%d' -d "$a + day" )
d2=$(date '+%d-%m-%Y' -d "$a + day" )

 
done</home/vinod/debit/ldtemp.out
echo $('date' -d "$d" '+%Y-%m-%d %H:%M:%S') >>/home/vinod/debit/ls.out
echo "$d" >> /home/vinod/debit/lastday.out
rm /home/vinod/debit/ldtemp.out

>/home/vinod/debit/k1.log
>/home/vinod/debit/k2.log
>/home/vinod/debit/k3.log
#final.out
cd /media/panda/kubera*
sed -e '/analyzeKL("Icici*/!d' $(pwd)/kubera.$d2.log >>/home/vinod/debit/k1.log
sed -e 's/.*("\([A-Za-z]*\)", "\([0-9]*\)")/\1\t\2/g' /home/vinod/debit/k1.log >>/home/vinod/debit/k2.log

awk -F'\t' '{ print $2 }' /home/vinod/debit/k2.log >>/home/vinod/debit/k0.log 
#awk -F'\t' 'FNR == 1{ print $1 }' k2.log >>org.out 

sort -u /home/vinod/debit/k0.log >> /home/vinod/debit/k3.log

awk 'BEGIN{printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n", "DATE" ,"START_DATE","END_DATE","ClientTxnId","PLPTxnId","DATA_DIR","INST_ID", "TOTAL_NUM_TRANS","TOTAL_NUM_DEBIT_TRANS","TOTAL_NUM_CREDIT_TRANS","TOTAL_DEBIT_WITH_CHEQUE_NUM","TOTAL_CREDIT_WITH_CHEQUE_NUM","TOTAL_OTHERS","TOTAL_OTHERS_WITHOUT_CHEQUE";}' >> /home/vinod/debit/PerfiosInsight_Cheque_Coverage_$d2.out

#awk 'BEGIN{printf "%-5s\t%-5s\t%-5s\t%-5s\t%-5s\t%-5s\t%-5s\t%-5s\t%-5s\n", "DATE","DIRECTORIES","ORGANIZATION", "CLIENT_TRANS_ID","ITYPE","INS_ID","TRANS_COUNT","OTHER_COUNT","per_cat";}'  >> /home/vinod/insid/final.out
cd /home/vinod/debit
while read line 
do


 #mkdir $line.out   
   
cd /media/panda/appserver-data/$d*
    cd $line

sed -e 's/\t\t/\tNA\t/g' /media/panda/appserver-data/$d*/$line/xns1.out >>/home/vinod/debit/xns.out

awk -F'\t' -f /home/vinod/debit/d.awk /media/panda/appserver-data/$d*/$line/summary.dat >>/home/vinod/debit/s.out
sed -i -e '/^$/d' /home/vinod/debit/s.out
awk -F'\t' -f /home/vinod/debit/c.awk /media/panda/appserver-data/$d*/$line/personal.dat >>/home/vinod/debit/p.out
sed -i -e '/^$/d' /home/vinod/debit/p.out

awk -F'\t' -v P="$(pwd)" -v D="$d2" -f /home/vinod/debit/count.awk  /home/vinod/debit/xns.out >>/home/vinod/debit/PerfiosInsight_Cheque_Coverage_$d2.out
#rm /home/vinod/debit/x.out
rm /home/vinod/debit/xns.out
rm /home/vinod/debit/s.out
rm /home/vinod/debit/p.out
done </home/vinod/debit/k3.log
#sed -i -e 's/[a-z\/\-]*[0-9\-]* ([0-9\-]*)\///g' /home/vinod/debit/x.out
sed -i -e 's/\/media\/panda\/appserver-data\///g' /home/vinod/debit/PerfiosInsight_Cheque_Coverage_$d2.out

sed -i -e 's/^\([0-9\-]*\)\t[a-z\/\-]*\([0-9\-]*\)/\1\t\2/g' /home/vinod/debit/PerfiosInsight_Cheque_Coverage_$d2.out

sed -i -e 's/\t\t/\t0\t/g' /home/vinod/debit/PerfiosInsight_Cheque_Coverage_$d2.out
sed -i -e 's/\t$/\t0/g' /home/vinod/debit/PerfiosInsight_Cheque_Coverage_$d2.out

rm /home/vinod/debit/k1.log
rm /home/vinod/debit/k2.log
rm /home/vinod/debit/k3.log
rm /home/vinod/debit/k0.log


 
