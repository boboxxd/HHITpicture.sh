#!/bin/bash
for file in *jpg
do 
echo $file | gawk -F _ {'print $3'} >> tmp.txt
done

cat tmp.txt | sort | uniq >> scene.txt && rm -rf tmp.txt


for ctype in `cat scene.txt`
do
if [ ! -e $ctype ]
then
mkdir ./$ctype
fi

find ./  -maxdepth 1  -type f -name "*$ctype*"  -print0 | xargs -0 -I {}  mv {}  $ctype

done


