#!/bin/bash

for file in *xml
do 
echo $file 
sed  -i "/object/,/object/d" $file

done
