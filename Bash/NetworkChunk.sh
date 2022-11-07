#! /bin/bash
# ------------------------ lesson ONE ------------------------- #

# echo  "salam $1 $2 /n khobi ?"
# ╰─$ ./Test.sh MohammadReza Izadi
# salam MohammadReza izadi /n khobi ?

# or
# firstname=$1
# lastname=$2
# age=$3
# echo  "Hello $firstname $lastname You are $age years old"
# ╰─$ ./Test.sh MohammadReza Izadi 27
#Hello MohammadReza Izadi You are 27 years old

#####################################
# echo what is your name ?
# read name
# echo How old are you
# read age
# echo  "Hello $name You are $age years old"

# ------------------------ lesson TOW -------------------------- #

# user=$(whoami)
# echo $user

# date=$(date)
# echo $date
#echo "hello every body i'm $firstname $lastname i'm login with $user user to this  system and i'm very happy this moment $date"


# ------------------------ lesson TREE ------------------------- #
# this BASH script will make you a MILLIONAIRE (Youtube )
####### New Concept

# echo "$RANDOM, $SHELL , $PWD, $HOSTNAME, $USER, $(date)"


# ------------------------ lesson FOUR ------------------------- #
#sudo -i
# nano ./bashrc



# ------------------------ lesson FIVE ------------------------- #
# #! /bin/bash

# echo "Hey, do you like coffee? (y/n)"
# read coffee

# if [[ $coffee == "y" ]];then 
#     echo "you're awesome"
# else
#     echo "Leave right now!!!"
# fi
#
# ------------------------ lesson SIX ------------------------- #

################### GAME
# beast=$(( $RANDOM % 2))
# echo "Your first beats approches. prepare to battle. Pick a number between 0-1. (0/1)"


# read tarnished

# if [[ $beast == $tarnished ]]; then
#     echo "Beats VANQISHED!! Congrats fellow tarnished"
# else
#     echo "You Died"
# fi

###################################
# select between 0 or 1 if ok go to next Round
beast=$(( $RANDOM % 2))
echo "Your first beats approches. prepare to battle. Pick a number between 0-1. (0/1)"
read tarnished
if [[ $beast == $tarnished && 2 > 1 ]]; then
    echo "Beats VANQISHED!! Congrats fellow tarnished"
else
    echo "You Died"
    exit 1
fi
echo "Wait for Round 2"
echo "------------------------"
sleep 2
echo "Round 2 Started"
# Round 2
echo "Boss battle. Get scared. It's Matgit. pick a number betwen 0-9. (0/9)"
read tarnished

beats=$(( $RANDOM % 10))
if [[ $beast == $tarnished || $tarnished == "coffee" ]]; then
    echo "Beats VANQISHED"
elif [[ $USER == "tito" ]]; then
        echo "Your number not True *You Died*"
else
    echo "You Died"
fi
#_______________________________________________ 
