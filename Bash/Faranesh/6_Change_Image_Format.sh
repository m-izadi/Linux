#! /bin/bash
rm -rf pic/image
clear
#IFS=$'\n'
mkdir pic/image
mkdir pic/image/newformat
cp pic/*.png pic/image
png_file=`ls pic/image/*`
a=1
for i in $png_file;do
    convert $i -resize 50% pic/image/newformat/image$a.jpg
    echo "image$a.jpg created!"
    ((a++))
done