#!/bin/bash  
dir=$1/*
tempname=`basename $1`
des=$2/$tempname
# Test the destination dirctory whether exists
[ ! -d $des ] && mkdir $des
# Create the destination dirctory
#des="/home/xxd/11111111"
#dir="/home/xxd/Desktop/20161215/*"
i=0
n=`echo $dir |wc -w` 
{
for file in `echo $dir`
  do
# Calculate progress
percent=$((100*(++i)/n))
cat <<EOF
XXX
$percent
Copying file $file ...
XXX
EOF
cp -r  $file $des &>/dev/null
  done } | dialog --title "Copy" --gauge "files" 6 70
clear
echo -e "\033[32m>>copy finished.\033[0m"
