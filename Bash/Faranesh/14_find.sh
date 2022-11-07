#! /bin/bash
IFS=$'\n'
clear 
echo Wellcome to my code
# find /home/dev/Documents -name "*.pdf" 2>/dev/null
files=( `find /Documents -name "*.pdf" 2>/dev/null` )
number_file=${#files[@]}
echo "number of " $number_file
mkdir /Documents/pdf 2>/dev/null
j=0
for ((i=0; i<$number ;i++));do
	(( j++ ))
	cp "/Documents/${files[i]}" "/Documents/pdf"
	echo -e "$j - ${files[i]} copied!  "
done
