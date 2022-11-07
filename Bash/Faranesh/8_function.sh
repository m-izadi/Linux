#!/bin/bash
clear
mina(){
    date +%H:%M
    echo "********************"
    date +%F
}

echo "##############################################"
echo "Hello date is :"
mina
####################################################
echo "##############################################"
add_function ( ){
    echo $1 "*" $2 = $(( $1 * $2 ))

}
add_function 2 3
add_function 4 5 
####################################################
echo "##############################################"
filnal_result ( ){
    result=$(( $1 + $2 ))
    echo $result
}
a=`filnal_result 5 6`
filnal_result a 5

