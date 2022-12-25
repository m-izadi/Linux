#!/bin/bash
# https://github.com/MohammadReza-izadi/iops-check
# read -p " Please enter Drive Name : " sd
sd=sda
LRED="\033[1;31m" # Light Red 
LGREEN="\033[1;32m" # Light Green
# Convert
    # convert-size(){
    # while read B dummy; do
    #   [ $B -lt 1024 ] && echo ${B} bytes/s && break
    #   KB=$(((B+512)/1024))

    #   [ $KB -lt 1024 ] && echo ${KB} kilobytes/s && break
    #   MB=$(((KB+512)/1024))

    #   [ $MB -lt 1024 ] && echo ${MB} megabytes/s && break
    #   GB=$(((MB+512)/1024))

    #   [ $GB -lt 1024 ] && echo ${GB} gigabytes/s && break
    #   echo $(((GB+512)/1024)) terabytes
    # done
    # }
echo "###########################################################################"
echo "###########################  ioping ( Free IOPs ) #########################"
echo "###########################################################################"
echo "################ Sequential & Default request size to 256 #################"
sudo ioping -RLB /dev/$sd | awk '{print $4,"b/s(transfer speed)"}'
# sudo ioping -RLB /dev/$sd | awk '{print $4,"b/s(transfer speed)"}' | convert-size
sudo ioping -RLB /dev/$sd | awk '{print $4,"b/s(transfer speed)"}' | awk '{$1/=(1024*1024);printf "%.2f MB/s\n",$1}'
# echo "########################### Random ########################################"
# sudo ioping -RB /dev/$sd | awk '{print $4,"b/s(transfer speed)"}' 
# # megabytes/s
# sudo ioping -RB /dev/$sd | awk '{print $4,"b/s(transfer speed)"}' | awk '{$1/=(1024*1024);printf "%.2f MB/s\n",$1}'

echo "###########################################################################"
echo "#######################  iostat ( Consumption IOPs ) ######################"
echo "###########################################################################"
# sudo iostat -dx $sd | grep $sd | awk '{ print $3" rkB/s | "$9" wkB/s"; } {s=$3+$9}{print "Already Disk Usage "s" kB/s"}'
sudo iostat -dx $sd | grep $sd | awk '{ print $4" rkB/s / "$5" wkB/s"; } {s=$4+$5}{print "Already Disk Usage "s" kB/s"}'
sudo iostat -dx $sd | grep $sd | awk '{s=$4+$5} {print int(s)}'| awk '{$1/=1024;printf "%.2fMB\n",$1}'


echo "Bye"
