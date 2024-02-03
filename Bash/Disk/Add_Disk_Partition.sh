#!/bin/bash
# sudo chmod +x Add_Disk+Partition.sh
# sudo ./Add_Disk+Partition.sh
echo -e " \033[32;9;7;102mWaiting...\033[0m"
echo "- - -" | sudo tee -a /sys/class/scsi_host/host2/scan
export SCAN_TEMP=$(mktemp -d)
ls /dev/sd? > ${SCAN_TEMP}/before.txt
for i in /sys/class/scsi_host/host*/scan
do
    echo "- - -" >> $i
done
ls /dev/sd? > ${SCAN_TEMP}/after.txt
for i in $(diff ${SCAN_TEMP}/before.txt ${SCAN_TEMP}/after.txt | grep \> | awk -F/ '{print $NF}'); do
    echo Added /dev/$i:
    /sbin/sfdisk -uM -l /dev/$i | grep -E "^/dev/$i" | awk '{print "    "$1" "$4" MiB"}'
done
rm -rf ${SCAN_TEMP}
touch scan-fdisk
touch scan-dfhpvs
ls /dev/sd? | grep -v /dev/sda > scan-fdisk
df -h | grep -v /dev/sda1 |  grep -v /dev/sda2 | grep -v /dev/sda3 |  grep  /dev/sd | awk '{print $1}' > scan-dfhpvs
pvs | grep -v /dev/sda1 |  grep -v /dev/sda2 | grep -v /dev/sda3 |  grep  /dev/sd  | awk '{print $1}' >> scan-dfhpvs
cat scan-fdisk > result
for l in $(cat scan-dfhpvs); do grep -v $l result >  result2; cat result2 > result; done
hasan=$(tail result)
ali=''
while [ true ]
do      echo "Enter the Partition number"
read number
if [ -z ${number} ]
then
    continue
else
    ali=${number}
    break
fi
done
for (( c=1; c<=${number}; c++ ))
do
    mamad=''
    while [ true ]
    do                echo "Enter the Partition Name $c"
    read lvs
    if [ -z ${lvs} ]
    then
        continue
    else
        mamad=${lvs}
        break
    fi
done
d=$(pvs | grep ${lvs} | awk 'FNR == 1 {print $2}')
if [ $( echo $d | grep -i "$lvs" | wc -l) -eq 1 ]
then
   echo Error! Partition has existed before. Try again.
   exit 1
fi
#zare=$(pvs | grep ${hasan} | awk 'FNR == 1 {print $5}' | cut -c2- | awk '{ print substr( $0, 1, length($0)-4 ) }')
echo ${zare}
if [ ${c} -eq 1 ]
then
    vgs=${lvs}
    pvcreate ${hasan} >/dev/null
    vgcreate ${vgs} ${hasan} >/dev/null
fi
if [ ${number} -eq 1 ]
then
    lvcreate -n ${lvs} -l 100%FREE ${lvs} >/dev/null

elif [ ${number} -gt 1 ]
    then
zare=$(pvs | grep ${hasan} | awk 'FNR == 1 {print $6}' | awk '{ print substr( $0, 1, length($0)-4 ) }')
        hadi=''
        while [ true ]
        do                echo "Enther the Partition Size $c, Maximum Size ${zare}Gb (Please type just number)"
        read size
        if [ -z ${size} ]
        then
            continue
        else
            hadi=${size}
            break
        fi
    done
    lvcreate -n ${lvs} -L +${size}G ${vgs} >/dev/null
fi
mkfs.ext4 /dev/${vgs}/${lvs} >/dev/null
if grep -q "${lvs}" /etc/fstab; then
    : nothing
else
   echo "/dev/${vgs}/${lvs}    /${lvs}    ext4    defaults    0    2"  >> /etc/fstab
fi
mkdir -p /${lvs}
mount /dev/${vgs}/${lvs} /${lvs} >/dev/null
done
rm -rf scan-dfhpvs
rm -rf scan-fdisk
rm -rf result
rm -rf result2
echo -e "\e[32mDone\e[0m"
