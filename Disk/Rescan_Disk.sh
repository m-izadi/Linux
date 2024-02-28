#!/bin/bash
for host in $(ls /sys/class/scsi_host) ; do echo ${host}; echo "- - -" > /sys/class/scsi_host/${host}/scan ; done

echo 1 > /sys/block/sda/device/rescan

#To scan for new disks :
echo "- - -" | sudo tee /sys/class/scsi_host/host*/scan >/dev/null

#To rescan existing disks :
echo 1 | sudo tee /sys/class/block/sd?/device/rescan >/dev/null

# sudo chmod +x Rescan_Disk.sh
# sudo ./Disk.sh
