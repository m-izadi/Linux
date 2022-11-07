#! /bin/bash
clear
gnu_linux=("xubuntu" "arch" "fedora" "debian" "ubuntu" "centos" "redhat" )
echo "Please enter 6 number"
for i in {0..5};do
    read -p "Please enter number No. $((i+1)): " number
    number_array[i]=$number
done
echo ${number_array[*]}
min=${number_array[0]}
for i in {1..5};do
    if [ "${number_array[i]}" -lt "$min" ];then
        min=${number_array[i]}
    fi
done

max=${number_array[0]}
for i in {1..5};do
    if [ "${number_array[i]}" -gt "$max" ];then
        max=${number_array[i]}
    fi
done
echo -e "minimum is $min\nmaximum is $max"

# ./13_araye.sh|  echo ${gnu_linux[2]}
# echo ${gnu_linux[10]} 13_araye.sh
# ./13_araye.sh|  gnu_linux[10]="mint"
# echo ${#linux[@]}
# echo ${gnu_linux[@]:2:4}