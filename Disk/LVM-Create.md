## Create PV
    pvcreate /dev/sdc
## Create VG
    vgcreate data /dev/sdc
## Create LV
    lvcreate -n lv-data -l 100%FREE data
## Check LVM
    lvs
    lvdisplay
## Format
    mkfs.ext4 /dev/data/lv-data 
## Auto Mount
    vim /etc/fstab 
        /dev/data/lv-data    /data    ext4    defaults    0    2
## Manuall Mount
    mount -a
## Check
    lsblk