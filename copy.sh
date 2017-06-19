#!/bin/bash
for file in *xml
do 
grep -l copy $file
done
