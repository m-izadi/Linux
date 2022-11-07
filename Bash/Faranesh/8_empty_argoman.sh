#!/bin/bash
clear
input=$1
if [ -z $input ];then
    read -p " please enter a name : " input
fi
echo " Hello $input "
