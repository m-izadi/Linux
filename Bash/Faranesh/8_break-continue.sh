#!/bin/bash
clear
while [ "1" == "1" ];do
    read -r -p "please enter name: " name
    if [ "$name" == "mina" ];then
        echo "OK $name"
        break
    fi
    echo "Try again!!!"
done
