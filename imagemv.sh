#!/bin/bash
########################################################$$$############
#function:checkfile 中删掉不符合条件的内容，然后从srcfile中获取符合的内容
#version 1.0
# author:xxd
########################################################################
if [  $# -ne 2 ]
then
	echo "Usage: sh imagemv.h checkdir srcdir"
	exit
fi

#checkimage
#checkdir="/media/xxd/KINGSTON/tower_crane_arm/2"
checkdir=$1
#sourceimage
#srcdir="/media/xxd/KINGSTON/tower_crane_arm/1"
srcdir=$2

#存放没问题的图片
if [ ! -e noresult ]
then
mkdir noresult &> /dev/null
fi

for file in `ls $checkdir`
do
  name=${file%.*}.xml
  mv $srcdir/$file $srcdir/$name noresult &>/dev/null

if [ 0 -eq $? ]
then
  echo "moving $file and $name success"
else 
  echo "moving $file and $name failed"
fi

done

