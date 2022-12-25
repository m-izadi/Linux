#! /bin/bash
# https://github.com/MohammadReza-izadi/iops-check
clear
sd=sda
LRED="\033[1;31m" # Light Red 
LGREEN="\033[1;32m" # Light Green
NC='\033[0m' # No Color\
################################################### Find Block Size ####################################################
# LINK: https://unix.stackexchange.com/questions/579480/how-do-i-determine-the-block-size-for-ext4-and-btrfs-filesystems
# On ext4, just use tune2fs to check your block size
# sudo stat -f /dev/sda1 |grep "^Block size:" | awk '{ print $3}'
block_size=`sudo tune2fs -l /dev/sda1 |grep "^Block size:" | awk '{ print $3}'`
if [ -z $block_size ];then
    block_size=`sudo tune2fs -l /dev/sda2 |grep "^Block size:" | awk '{ print $3}'`
fi
if [ -z $block_size ];then
    block_size=`sudo tune2fs -l /dev/sda3 |grep "^Block size:" | awk '{ print $3}'`
fi
echo -e "${LGREEN}\n\nSystem Block Size is $block_size"
########################################################################################################################
echo -e "\n${LGREEN}###########################################################################"
echo "########################  ioping ( Total Free IOPs In VM) #######################"
echo "###########################################################################"
echo "################ Sequential & Default request size to 256 #################"
sudo ioping -RLB /dev/$sd | awk '{print $4,"b/s(transfer speed)"}' | awk '{$1/=(1024*1024);printf "%.2f MB/s\n",$1}'

echo "######### Sequential & request size to $block_size (System Block Size) #########"
sudo ioping -RLB -s $block_size /dev/$sd | awk '{print $4,"b/s(transfer speed)"}' | awk '{$1/=(1024*1024);printf "%.2f MB/s\n",$1}'

echo "################ Sequential & request size to 64k #################"
sudo ioping -RLB -s 64k /dev/$sd | awk '{print $4,"b/s(transfer speed)"}' | awk '{$1/=(1024*1024);printf "%.2f MB/s\n",$1}'

echo "###########################################################################"
echo "#######################  iostat ( Consumption IOPs ) ######################"
echo "###########################################################################"
sudo iostat -dx $sd | grep $sd | awk '{ print $4" rkB/s / "$5" wkB/s "; } {s=$4+$5}{print "Already Disk Usage "s" kB/s"}'
sudo iostat -dx $sd | grep $sd | awk '{s=$4+$5} {print int(s)}'| awk '{$1/=1024;printf "%.2fMB\n",$1}'
echo "####################################################################################"
echo "#######################  DD (server throughput (write speed)) ######################"
echo "####################################################################################"
echo ""
sudo dd if=/dev/zero of=/tmp/test1.img bs=500M count=1 oflag=dsync | awk '{s=$6+$7} {print int(s)}'
echo "##################################################################################"
echo "################### Container (server throughput (Read speed)) ###################"
echo "##################################################################################"
echo "(defaulting to 4k)"
# pattern = "-p sequential"
sudo git clone https://github.com/benschweizer/iops
cd iops
sudo docker run --rm -it --device=/dev/$sd cxcv/iops --block-size 256 --num-threads 2 /dev/$sd
sudo docker run --rm -it --device=/dev/$sd cxcv/iops --block-size 4096 --num-threads 2 /dev/$sd
sudo docker run --rm -it --device=/dev/$sd cxcv/iops --block-size 65536 --num-threads 2 /dev/$sd
echo "###########################################################################"
echo "################################### END ###################################"
echo "###########################################################################${NC}"
