#!/bin/bash
delivery_path=/mnt/share/front/public/image/
image=routaa-public-node_run:14.15.4-alpine.bz2
docker_compose=/srv/docker-composes/front.yml

###### Remove old containers ######

echo -e "------# removing old containers... #----------"
ssh support@192.168.19.12 -o ConnectTimeout=15 docker rm -f public1 public2
if [ $? -eq 0 ]
        then
                echo -e "\n------removing old containers completed... #---------"
        else
                echo -e "\n------removing old containers failed... #---------"
fi


###### Remove old image ######

echo -e "------# removing old images... #----------"
ssh support@192.168.19.12 -o ConnectTimeout=15 docker rmi routaa-public-node_run:14.15.4-alpine
if [ $? -eq 0 ]
        then
                echo -e "\n------removing old images completed... #---------"
        else
                echo -e "\n------removing old images failed... #---------"
fi

###### loading new image ######

echo -e "------# loading new image... #----------"
ssh support@192.168.19.12 -o ConnectTimeout=15 docker load -i $delivery_path/"$image"
if [ $? -eq 0 ]
        then
                echo -e "\n------loading new image completed... #---------"
        else
                echo -e "\n------loading new image failed... #---------"
fi





###### healthcheck #######
for i in 1 2
do
        ssh support@192.168.19.12 -o ConnectTimeout=15  docker-compose -f "$docker_compose" up -d public$i
        exit_dc_up=$?
        if [ $exit_dc_up -eq 0 ]
        then
                echo -e "\n------running docker-compose up public$i on node1 completed... #---------"
        else
                echo -e "\n------running docker-compose up public$i on node1 failed... #---------"
                break
        fi
        declare -i counter success
        counter=0
        success=0
        while [ $counter -lt 180 ] && [ $success -eq 0 ];do
        curl -m 2 -s -I 192.168.19.12:809$i | grep 200
        if [ $? -eq 0 ]
        then
                success=1
                echo -e "\n------------# on node1  public$i test was successfull. #-----------"
        else
                sleep 2
                counter=$counter+1
        fi
        done
        if [ $success -ne 1 ]
        then
                echo -e "\n------------# on node1 public$i test was unsuccessfull!!! #-----------"
        fi
done
