#!/bin/bash
for host in $(ls /sys/class/scsi_host) ; do echo ${host}; echo "- - -" > /sys/class/scsi_host/${host}/scan ; done

echo 1 > /sys/block/sda/device/rescan

# sudo chmod +x Rescan_Disk.sh
# sudo ./Disk.sh
