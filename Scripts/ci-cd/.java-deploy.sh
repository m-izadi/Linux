#!/bin/bash
############## Light/Color ##############
LRED="\033[1;31m" # Light Red
LGREEN="\033[1;32m" # Light Green
NC='\033[0m' # No Color
######################################################################
src_path_file=/tmp/back/ci-images
dst_path_file=/srv/ci-images
docker_compose_status="up"
# read the option and store in the variable, $option
while getopts ":s:p:P:t:d:D:" options; do
    case "${options}" in
        s)
            service_name=${OPTARG}
            echo -e "\U1F4CC Service-Name: $service_name "
            ;;
        t)
            target_server=${OPTARG}
            echo -e "\U1F4CC Deploy $service_name in $target_server "
            ;;
        p)
            src_path_file=${OPTARG}
            echo -e "\U1F4CC SRC_Path_File is $src_path_file on Middle Node(Monitor) "
            ;;
        P)
            dst_path_file=${OPTARG}
            echo -e "\U1F4CC DST_Path_File is $dst_path_file On $target_server Node "
            ;;
        d)
            docker_compose_file=${OPTARG}
            echo -e "\U1F4CC Docker-Compose-File: $docker_compose_file "
            ;;
        D)
            docker_compose_status=${OPTARG}
            echo -e "\U1F4CC Docker-Compose-Status: $docker_compose_status "
            ;;
        *)
            echo -e "\U1F4A1\U2757 You must use options "
            exit 1
            ;;
    esac
done
if [ -z "$service_name" ];then
    read -pr " Please enter the Service Name : " service_name
fi
image="$service_name:v1.tar.gz"

echo -e "#### \U1F4C8 Sending $image \U1F4C8 ####"
# scp "$src_path_file"/"$image" "$target_server":"$dst_path_file"
if scp "$src_path_file"/"$image" "$target_server":"$dst_path_file";
        then
                echo -e "$LGREEN \U2705 ################# Image Sent Successfully #################\n$NC"
        else
                 echo -e "\n\n$LRED\U274C ################# There is a PROBLEM with Sending the image #################\n$NC"
                exit 1
fi

echo -e "#### \U231B Load New Image \U231B  ####"
# ssh "$target_server" -o ConnectTimeout=15 docker load -i "$dst_path_file"/"$image"
if ssh "$target_server" -o ConnectTimeout=15 docker load -i "$dst_path_file"/"$image" ;
        then
                echo -e "$LGREEN \U2705 ################# Load New Image Successfully #################\n$NC"
        else
                echo -e "\n\n$LRED\U274C ################# There is a PROBLEM with Loading the image #################\n$NC"
                exit 1
fi

###### Remove old containers ######
#echo -e "#### Remove container ####"
#ssh $target_server -o ConnectTimeout=15 docker rm -f $service_name
#if [ $? -eq 0 ]
#        then
#                echo -e "$LGREEN################# Remove old Container Successfully #################$NC"
#        else
#                echo -e "$LRED################# There is a problem, the Container could not be Remove #################$NC"
#fi
######### start new-image ######
if [ "$docker_compose_status" == "up" ]
        then
            echo -e "$LGREEN \U2705 ################# Starting the container #################\n$NC"
            ssh "$target_server" -o ConnectTimeout=15 docker-compose -f /srv/docker-composes/"$docker_compose_file" up -d --force-recreate "$service_name" || \
            ssh "$target_server" -o ConnectTimeout=15 docker compose -f /srv/docker-composes/"$docker_compose_file" up -d --force-recreate "$service_name" && \
            echo -e "$LGREEN \U2705 ################# The container was launched successfully #################\n$NC"
        else
            echo -e "$LGREEN \U2705 ################# Image Loaded / The process is over #################\n$NC"
fi