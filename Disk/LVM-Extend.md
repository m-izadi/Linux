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