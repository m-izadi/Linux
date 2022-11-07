#! /bin/bash
clear
number=1
until [ $number == 10 ];do
echo $number
((number++))
done

echo -e "______________________________\n"

number2=1
while [ $number2 != 10 ];do
echo $number2
((number2++))
done