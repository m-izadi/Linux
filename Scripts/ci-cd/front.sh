#!/bin/bash
latest_path_tmp=/tmp/front/public/images/routaa-public-node_run:14.15.4-alpine.bz2
delivery_path=/mnt/share/front/public/image/
backup_path=/mnt/share/front/public/bak/image/
image=routaa-public-node_run:14.15.4-alpine.bz2
bak_file=routaa-public-node_run:14.15.4-alpine-$(date +%F-%H%M).bz2

###### backup ######

echo -e "------# backing up old image... #----------"

ssh support@192.168.19.11 -o ConnectTimeout=15 cp $delivery_path"$image" $backup_path"$bak_file"
if [ $? -eq 0 ]
        then
                echo -e "\n------backup completed... #---------"
        else
                echo -e "\n------backup failed... #---------"
fi


###### delivery new files ######

echo -e "------# deploying new image... #----------"


rsync -avzhe 'ssh -o ConnectTimeout=15' $latest_path_tmp support@192.168.19.11:$delivery_path


if [ $? -eq 0 ]
        then
                echo -e "\n------deploying new image completed... #---------"
        else
                echo -e "\n------deploying new image failed... #---------"
fi
