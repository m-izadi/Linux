#!/bin/bash
############## Light/Color ##############
LRED="\033[1;31m" # Light Red
LGREEN="\033[1;32m" # Light Green
NC='\033[0m' # No Color
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

############## Time & Date ##############
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