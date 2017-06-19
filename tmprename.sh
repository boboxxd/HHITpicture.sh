#!/bin/bash
date=`date +%Y%m%d%M%S`
num=1
for file in *jpg
do
m=`printf "%04d" $num`
namepart=${file%.*}
mv $file $date$m.jpg
#mv $namepart $date$m.xml
num=`expr $num + 1`
done


