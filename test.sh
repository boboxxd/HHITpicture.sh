#!/bin/bash
Match()
{
for file in *jpg
do
name=${file%.*}.xml
if [ ! -f $name ]; then 
echo $file

fi
done
}

while [ -n "$1" ]
do
  case $1 in
  -a) result=$(Match);echo $result;;
  -b) echo "found the -b option";;
  -c) echo "found the -c option";;
  --) shift         
      break ;;
  *) echo "$1 is not an option";;
  esac
  shift
done
count=1
for param in $@
do
  echo "parameter #count:$param"
  count=$[ $count + 1 ]
done


