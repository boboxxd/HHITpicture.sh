#!/bin/bash
# version 1
date=`date +%Y%m%d`
count=1
for file in *.jpg
do
   m=`printf "%04d" $count`
#echo $count
#echo $m

   mv $file $date$m.jpg
   count=`expr $count + 1`
done

