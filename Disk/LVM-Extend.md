https://networklessons.com/uncategorized/extend-lvm-partition

fdisk /dev/sdc

    m
    n
    p
    w

lsblk

pvcreate /dev/sdc1

vgdisplay | grep Name

    VG Name               data01

vgextend data01 /dev/sdc1

    Volume group "data01" successfully extended

vgdisplay

lvdisplay | grep Path

    LV Path                /dev/data01/lv-data01

lvextend -l +100%FREE /dev/data01/lv-data01

    Size of logical volume data01/lv-data01 changed from <500.00 GiB (127999 extents) to 999.99 GiB (255998 extents).
    Logical volume data01/lv-data01 successfully resized.

resize2fs /dev/data01/lv-data01

    resize2fs 1.46.5 (30-Dec-2021)
    Filesystem at /dev/data01/lv-data01 is mounted on /data; on-line resizing required
    old_desc_blocks = 63, new_desc_blocks = 125
    The filesystem on /dev/data01/lv-data01 is now 262141952 (4k) blocks long.

lsblk

df -mh


==================================================================================================================

# Scan New Disk

### echo 1 | sudo tee /sys/class/block/sd?/device/rescan >/dev/null

### lsblk

    sdc                     8:32   0     2T  0 disk 
    └─sdc1                  8:33   0  1024G  0 part 
      └─data01-lv--data01 252:0    0   1.5T  0 lvm  /data


### cfdisk /dev/sdc

    Resize
    Write
        yes

### lsblk

    sdc                     8:32   0     2T  0 disk 
    └─sdc1                  8:33   0     2T  0 part 
      └─data01-lv--data01 252:0    0   1.5T  0 lvm  /data

### pvdisplay

    --- Physical volume ---
    PV Name               /dev/sdc1
    VG Name               data01
    PV Size               <1024.00 GiB / not usable 2.00 MiB
    Allocatable           yes (but full)
    PE Size               4.00 MiB
    Total PE              262143
    Free PE               0
    Allocated PE          262143
    PV UUID               wvxerG-T5Z3-65J2-kjV7-DZiP-L4HI-80Pv1R


### pvresize /dev/sdc1

    Physical volume "/dev/sdc1" changed
    1 physical volume(s) resized or updated / 0 physical volume(s) not resized

### pvdisplay

    --- Physical volume ---
    PV Name               /dev/sdc1
    VG Name               data01
    PV Size               <2.00 TiB / not usable 2.00 MiB
    Allocatable           yes 
    PE Size               4.00 MiB
    Total PE              524287
    Free PE               262144
    Allocated PE          262143
    PV UUID               wvxerG-T5Z3-65J2-kjV7-DZiP-L4HI-80Pv1R


### df -mh

    /dev/mapper/data01-lv--data01  1.5T  1.4T  178M 100% /data

### lvextend -l +100%FREE /dev/mapper/data01-lv--data01

### resize2fs /dev/mapper/data01-lv--data01

### df -mh

    /dev/mapper/data01-lv--data01  2.5T  1.4T  968G  60% /data





