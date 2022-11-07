#! /bin/bash
clear
# read -p "Please enter first nubmer:  " f_number
# read -p "Please enter secound nubmer:  " s_number
# echo Plus is $((f_number+s_number))
# OR
# how to use argoman in script
counter=1
echo $1 + $2 = $(($1 + $2))

for i in "$@" ;do
    echo "$counter"_ hello $i
    ((counter++))
done