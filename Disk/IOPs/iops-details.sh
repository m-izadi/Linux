#!/bin/bash
# https://github.com/MohammadReza-izadi/iops-check
read -p " Please enter Drive Name : " sd
LRED="\033[1;31m" # Light Red 
LGREEN="\033[1;32m" # Light Green
# link: https://stackoverflow.com/questions/19059944/convert-kb-to-mb-using-bash
convert-size(){
while read B dummy; do
  [ $B -lt 1024 ] && echo ${B} bytes/s && break
  KB=$(((B+512)/1024))
  
  [ $KB -lt 1024 ] && echo ${KB} kilobytes/s && break
  MB=$(((KB+512)/1024))
  
  [ $MB -lt 1024 ] && echo ${MB} megabytes/s && break
  GB=$(((MB+512)/1024))
  
  [ $GB -lt 1024 ] && echo ${GB} gigabytes/s && break
  echo $(((GB+512)/1024)) terabytes
done
}

#########################
#Link: https://unix.stackexchange.com/questions/240651/how-to-find-the-max-io-a-physical-disk-can-support
#Need File
# echo "${LGREEN}###########################################################################"
# echo "${LGREEN}############################## Test with DD ###############################"
# echo "${LGREEN}###########################################################################"
# read -p " Please enter File to check iops : " File
# echo $File
# sudo dd if=/dev/$sd of=$File bs=8k count=10000; sync;
echo "###########################################################################"
echo "############################ Test with ioping #############################"
echo "###########################################################################"
echo "Free Iops"
echo "Sequential & Default request size to 256 "
sudo ioping -RLB /dev/$sd | awk '{print $4,"b/s(transfer speed)"}' | convert-size
sudo ioping -RLB /dev/$sd | awk '{print $4,"b/s(transfer speed)"}' | awk '{$1/=(1024*1024);printf "%.2f MB/s\n",$1}'
echo "Random"
sudo ioping -RB /dev/$sd | awk '{print $4,"b/s(transfer speed)"}' | convert-size
sudo ioping -RB /dev/$sd | awk '{print $4,"b/s(transfer speed)"}' | awk '{$1/=(1024*1024);printf "%.2f MB/s\n",$1}'
echo "###########################################################################"
echo "Sequential & request size to 4K "
sudo ioping -RLB -s 4k /dev/$sd | awk '{print $4,"b/s(transfer speed)"}' | convert-size
echo "200 Count & Default 4k"
sudo ioping -p 100 -c 200 -i 0 -q /dev/$sd | awk '{print $4,"bytes/s(transfer speed)"}'
# sudo ioping -p 100 -c 200 -i 0 -q /dev/$sd | awk '{print $4,"bytes/s(transfer speed)"}' | convert-size
echo "###########################################################################"
echo "############################ Test with hdparm #############################"
echo "###########################################################################"
sudo hdparm -Tt /dev/$sd
echo "###########################################################################"
echo "############################ Test with iostat #############################"
echo "###########################################################################"
# sudo iostat -dx $sd | grep $sd | awk '{ print $3" rkB/s | "$9" wkB/s"; } {s=$3+$9}{print "Already Disk Usage "s" kB/s"}'
sudo iostat -dx sda | grep sda | awk '{ print $4" rkB/s / "$5" rkB/s"; } {s=$4+$5}{print "Already Disk Usage "s" kB/s"}'
sudo iostat -dx $sd | grep $sd | awk '{s=$4+$5} {print int(s)}'| awk '{$1/=1024;printf "%.2fMB\n",$1}'
echo "###########################################################################"
echo "############################ Test with Container #############################"
echo "###########################################################################"
read -p " Please enter threads to check iops : " threads
# read -p " Please enter pattern Default Random(Random/sequential) : " pattern
echo $pattern
if [ -z $threads ];then
    threads = "2"
fi
# if [ !-z $pattern ];then
#     pattern = -p $pattern
# fi
pattern = "-p sequential"
sudo git clone https://github.com/benschweizer/iops
cd iops
sudo docker run --rm -it --device=/dev/$sd cxcv/iops --num-threads $threads /dev/$sd
echo "###########################################################################"
echo "################################### END ###################################"
echo "###########################################################################"
