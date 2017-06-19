#!/bin/bash

num=0;
mark()
{
if [ ! -e "backgroudmodel.xml" ]
then
echo "缺少backgroudmodel.xml文件！"
exit 1
fi

count=`ls *jpg| wc -l`

for file in *.jpg
do

folder="background"
path=`readlink -f  $file`
filename=${file%.*}
width=`identify $file | gawk {'print $3'} | gawk -F x  {'print $1'}`
height=`identify $file | gawk {'print $3'} | gawk -F x {'print $2'}`

#echo width:$width
#echo height:$height
#echo folder:$folder
#echo filename:$filename



if [ ! -e "$filename.xml" ]
then
let num++
echo "($num:$count)" " $path"
cp backgroudmodel.xml  "$filename".xml
sed  -i "s#XXD1#$folder#"  "$filename".xml >/dev/null
sed  -i "s#XXD2#$filename#"  "$filename".xml >/dev/null
sed  -i "s#XXD6#$path#"  "$filename".xml >/dev/null
sed  -i "s#XXD4#$width#"  "$filename".xml >/dev/null
sed  -i "s#XXD5#$height#"  "$filename".xml >/dev/null
else
let num++
echo  "($num:$count)" " $filename.xml已存在，若要重新生成xml,请删除."
fi
done
}








read -p "此软件将会为当前路径下.jpg图片标记背景xml，是否继续？(Y/N)"  selection

case  $selection in
Y)
  mark;;
y)
  mark;;
N)
  exit 0;;
n)
  exit 0;;  
esac




