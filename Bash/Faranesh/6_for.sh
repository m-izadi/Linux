#! /bin/bash
clear
# for number in {1..9};do
# echo $number
# done

#or sintax #C

# for ((i=0;i<=100;i+=5));do
#     echo $i
# done

# for i in {0..100..5};do
#     echo $i
# done

#______________________________________________________
# IFS : Internal field seperator
IFS=":"
name="Mohammad:Erfun:Darya:Fatemeh"
for i in $name ;do
    echo hello $i
done
