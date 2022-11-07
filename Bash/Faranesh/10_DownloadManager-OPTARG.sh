#!/bin/bash
clearFile(){
    if [ -f "$pid".txt ];then
        rm "$pid".txt
    fi
}
sigmaTime(){
    local hour="$1"
    local minuts="$2"
    hour=${1#0}
    minuts=${2#0}
    if [ -z $hour ];then
        hour="0"
    fi
    if [ -z $minuts ];then
        minuts="0"
    fi
    echo $(( hour * 60 + minuts ))
}
dateTime(){
    date_hour=`date +%H:%M`
    date_hour=${date_hour/:/ }
    sigma_date=`sigmaTime $date_hour `
}
startTime(){
    local time="$1"
    time=${time/:/ }
    sigma_time=`sigmaTime $time`
    dateTime
    while [ "$sigma_date" != "$sigma_time" ];do
        echo $(("sigma_time" - "sigma_date")) "minutes until start"
        sleep 2
        dateTime
    done
}
downloadFunction(){
    aria2c -c -x 16 -s 16 -k 1M "$link"
    echo "1" > $pid.txt
}
endTime(){
    local time="$1"
    time=${time/:/ }
    sigma_time=`sigmaTime $time`
    dateTime
    while [ "$sigma_date" != "$sigma_time" ];do
        if [ -f "$pid".txt ];then
            exit
        fi
        sleep 2
        dateTime
    done
    killall aria2c
}
clear
trap clearFile exit
pid="$$"
#
while getopts "s:e:l:v" options;do
    case "$options" in
        s)
            "start_time_inp" ;;
        e)
            end_time_input="$OPTARG" ;;
        l)
            link="$OPTARG"
            if [ -z $link ];then
                echo " Error! please enter a link: "
                exit
            fi ;;
        v)
            echo " Hello This is my Download Manager"
            exit ;;
    esac
done
if [ -z $link ];then
    echo "Error! please enter a link:"

fi
if [ ! -z $start_time_input ];then
    startTime $start_time_input
fi

if [ ! -z "$end_time_input" ];then 
    downloadFunction &
    endTime $end_time_input
else
    downloadFunction
fi
exit

# start_time_input="11:21"
# end_time_input="15:19"
# link="https://cdna.p30download.ir/p30dl-software/Windows.11.May.2022_p30download.com.part1.rar"