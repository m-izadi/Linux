#!/bin/bash
############## Light/Color ##############
LRED="\033[1;31m" # Light Red
LGREEN="\033[1;32m" # Light Green
NC='\033[0m' # No Color
plain='\033[0m'

echo -e " \033[33;99;7;102mERROR\033[0m" # Yellow
echo -e " \033[32;99;7;102m\tWelcome\033[0m"

echo -e "${LRED}Test Light is down${NC}"
echo -e "${LGREEN}Test Light is down${NC}"
############## Counter/Loop ##############
declare -i counter success
counter=0
success=0
while [ $counter -lt 180 ];do
curl -m 2 -s google.com | grep OK
if [ $? -eq 0 ]
then
        success=1
        echo -e "${LGREEN}\n------------# google is up #-----------"
        break
else
        echo -e "${LGREEN} $counter Minutes Past"
        sleep 1m
        counter=$((counter+1))
        echo -e "$LRED\n-------------------- google Health check is Offline. -------------------"
        echo -e "${LGREEN}-------------------------- Please wite --------------------------"
fi
done
if [ $success -eq 1 ];then
echo "run command"
else
        echo -e "$LRED###########################   Health check is Offline    ###########################"
        echo -e "$LRED\n------------# on $deploy $Container_Name_Deploy Container has been failed! #-----------"
        ssh $ssh_to_local -o ConnectTimeout=15 -o StrictHostKeyChecking=no docker logs --tail 400 $Container_Name_Deploy
        ssh $ssh_to_local -o ConnectTimeout=15 docker stop $Container_Name_Deploy
        ssh $ssh_to_local -o ConnectTimeout=15 docker rm -f $Container_Name_Deploy
        exit 1
fi
;;

##################################
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













########################################
ssh $ssh_to_local -o ConnectTimeout=15 rsync -avzh $src_osm_path/$osm_name $dst_osm_path/$osm_name
ssh $ssh_to_node1 -o ConnectTimeout=15 rsync -avzh --delete-after  $src_osm_path/$osm_name $backend_car_path/$osm_name
ssh $ssh_to_local -o ConnectTimeout=15 -o StrictHostKeyChecking=no rsync -avzh --exclude 'back' --exclude 'logs' --exclude 'deploy' $orgin_graphhopper_dir/* $backup_dir/
rsync -avzh --delete-after 'ssh -o ConnectTimeout=15 -o StrictHostKeyChecking=no' $cache_path/$jar_name support@192.168.19.15:$dst_path_Deploy/$jar_name

##############  ##############
echo "------# Add upstream to nginx... #--------"
ssh support@192.168.19.15 sed -i 'LINENUMBER s/#/ /' /etc/nginx/conf.d/beroozbaazaar.com.conf
ssh support@192.168.19.15 nginx -s reload




############## Create DIR ##############
if [[ ! -e $backup_dir ]]; then
    mkdir $backup_dir
    echo -e "${LGREEN} Create $backup_dir dir is Succesfully"
elif [[ -d $dir ]]; then
    echo "$dir already exists but is not a directory" 1>&2
else
    echo "${LGREEN}$backup_dir already exists" 1>&2
fi

############## GetOpts/Argoman ##############

while getopts "l:v" options;do
    case "$options" in
        l)
            HealthCheck="$OPTARG"
            ;;
        v)
            echo -e "This script create new cache an replace to old cache "
            exit ;;
    esac
done

############## Zero Var ##############
if [ -z $HealthCheck ];then
    read -p " Please enter the Health Check URL (Default:127.0.0.1:8989/health) : " HealthCheck
fi

############## sed ##############
sed -r 's/^[a-d]{3}/r/' test.txt 
# ╰─$ cat test.txt 
# a
# ab
# abc
# abcd
# abcde
# abcdef
# abcdefg
# abcdefgh
# abcdefghy
# 09196744227
# 1bcdefghylmn
# absalam ab

############## Time & Date ############## Function
mina(){
    date +%H:%M
    echo "********************"
    date +%F
}
mina

############## Play Alarm(audo) ########
read -s -p "please enter name:  " name
while [ "$name" != mina ];do
        vlc beep2.wav &
    echo -e " \033[33;99;7;102mERROR\033[0m"
    read -s -p "please try again:  " name
    
done
############## Notif ########
if [ "$?" == 0 ];then
    echo $?
    notify-send "Download Complate"
else
    notify-send "Error"

fi


############## Date ########

echo -e "\n------------`date`-------------\n"

############## Latast File ########

latest_backup_name=$(ls $backup_path -trh1 | tail -1)                   Latest file
latest_backup_full_path=$(readlink -f $latest_backup_name)              Full Path File

readlink -f 1010324242346_iran_direction.osm

############## read ########

read -p “Please type your username” username

read -s -p “Please type your password” $password                                # input silent

read -t 5 -rp  "Would you like Set Proxy? (Default No) (Y/n) " proxy            # Answer in 5 seconds


############## Select ##############  The select mechanism allows you to create a simple menu system
#!/bin/bash
# A simple menu system
names='Kyle Cartman Stan Quit'
PS3='Select character: '
select name in $names
do
if [ $name == 'Quit' ]
then
break
fi
echo Hello $name
done
echo Bye

############## Function ##############

#!/bin/bash
# Basic function
print_something () {
echo Hello I am a function
}
print_something
print_something

############## tput ############## Here is an example printing a message in the center of the screen.
#https://ryanstutorials.net/bash-scripting-tutorial/bash-user-interface.php
#!/bin/bash
# Print message in center of terminal
cols=$( tput cols )
rows=$( tput lines )
message=$@
input_length=${#message}
half_input_length=$(( $input_length / 2 ))
middle_row=$(( $rows / 2 ))
middle_col=$(( ($cols / 2) - $half_input_length ))
tput clear
tput cup $middle_row $middle_col
tput bold
echo $@
tput sgr0
tput cup $( tput lines ) 0

############## Multi Select ##############
#!/bin/bash

# customize with your own.
options=("AAA" "BBB" "CCC" "DDD")

menu() {
    echo "Avaliable options:"
    for i in ${!options[@]}; do 
        printf "%3d%s) %s\n" $((i+1)) "${choices[i]:- }" "${options[i]}"
    done
    if [[ "$msg" ]]; then echo "$msg"; fi
}

prompt="Check an option (again to uncheck, ENTER when done): "
while menu && read -rp "$prompt" num && [[ "$num" ]]; do
    [[ "$num" != *[![:digit:]]* ]] &&
    (( num > 0 && num <= ${#options[@]} )) ||
    { msg="Invalid option: $num"; continue; }
    ((num--)); msg="${options[num]} was ${choices[num]:+un}checked"
    [[ "${choices[num]}" ]] && choices[num]="" || choices[num]="+"
done

printf "You selected"; msg=" nothing"
for i in ${!options[@]}; do 
    [[ "${choices[i]}" ]] && { printf " %s" "${options[i]}"; msg=""; }
done
echo "$msg"

############## Multi select ##############

!/bin/bash
#title:         menu.sh
#description:   Menu which allows multiple items to be selected
#author:        Nathan Davieau
#               Based on script from MestreLion
#created:       May 19 2016
#updated:       N/A
#version:       1.0
#usage:         ./menu.sh
#==============================================================================

#Menu options
options[0]="AAA"
options[1]="BBB"
options[2]="CCC"
options[3]="DDD"
options[4]="EEE"

#Actions to take based on selection
function ACTIONS {
    if [[ ${choices[0]} ]]; then
        #Option 1 selected
        echo "Option 1 selected"
    fi
    if [[ ${choices[1]} ]]; then
        #Option 2 selected
        echo "Option 2 selected"
    fi
    if [[ ${choices[2]} ]]; then
        #Option 3 selected
        echo "Option 3 selected"
    fi
    if [[ ${choices[3]} ]]; then
        #Option 4 selected
        echo "Option 4 selected"
    fi
    if [[ ${choices[4]} ]]; then
        #Option 5 selected
        echo "Option 5 selected"
    fi
}

#Variables
ERROR=" "

#Clear screen for menu
clear

#Menu function
function MENU {
    echo "Menu Options"
    for NUM in ${!options[@]}; do
        echo "[""${choices[NUM]:- }""]" $(( NUM+1 ))") ${options[NUM]}"
    done
    echo "$ERROR"
}

#Menu loop
while MENU && read -e -p "Select the desired options using their number (again to uncheck, ENTER when done): " -n1 SELECTION && [[ -n "$SELECTION" ]]; do
    clear
    if [[ "$SELECTION" == *[[:digit:]]* && $SELECTION -ge 1 && $SELECTION -le ${#options[@]} ]]; then
        (( SELECTION-- ))
        if [[ "${choices[SELECTION]}" == "+" ]]; then
            choices[SELECTION]=""
        else
            choices[SELECTION]="+"
        fi
            ERROR=" "
    else
        ERROR="Invalid option: $SELECTION"
    fi
done

ACTIONS

############## Emoji ##############
# https://unicode.org/emoji/charts/emoji-list.html#1f600
# https://apps.timwhitlock.info/emoji/tables/unicode

perl -CO -E 'say "\N{U+1F602}"'
perl -CO -E 'say "\N{U+1F4A9}"'
echo -n $'\U1F60D\n' 😍
echo -n $'\U1FAE1\n' 🫡
echo -n $'\U1F92C\n' 🤬
echo -n $'\U1F4A9\n' 💩
echo -n $'\U1F914\n' 🤔
echo -n $'\U1F4A4\n' 💤
echo -n $'\U1F44C\n' 👌
echo -n $'\U2705\n'  ✅
echo -n $'\U274C\n'  ❌
echo -n $'\U2757\n'  ❗
echo -n $'\U231B\n'  ⌛
echo -n $'\U1F44D\n' 👍
echo -n $'\U1F4A1\n' 💡
echo -n $'\U1F4CC\n' 📌
echo -n $'\U1F4E2\n' 📢
echo -n $'\U1F514\n' 🔔
echo -n $'\U1F527\n' 🔧
echo -n $'\U1F528\n' 🔨
echo -n $'\U1F527\U1F528 \n' 🔧🔨
echo -n $'\U1F534\n' 🔴
echo -n $'\U1F4C8\n' 📈
echo -n $'\U1F50D\n' 🔍


|| اگر قبلی نشد بعدی بشه
; قبلی شدن و نشدنش مهم نیست و دستور بعدی رو اجرا میکند
&& اگر دستور قبلی درست انجام شد دستور بعدی رو اجرا کن

 ###################################