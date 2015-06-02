

BEGIN{ 

while ( getline n < "/home/vinod/debit/s.out" > 0 )
bank = n;

while ( getline m < "/home/vinod/debit/p.out" > 0 )
user = m ;

}
match($4,/-[0-9\.]+/){
j++
if ($2 != "NA" )
{
h++
}
}
match($4,/-[0-9\.]+/){
if ($2 != "NA" )
{
i++;
}}
match($4,/^[0-9]+/){
k++
if ($2 != "NA" )
{
l++;
}

}
$6 == "Others"{
q++
if ( $2 == "NA" )
{
o++
}
}
END{printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n",D,user,P,bank,NR,j,k,h,l,q,o}
