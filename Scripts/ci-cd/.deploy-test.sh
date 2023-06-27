#!/bin/bash
############## Light/Color ##############
RED="\033[1;31m" # Light Red
GRN="\033[1;32m" # Light Green
NC='\033[0m' # No Color
######################################################################
src_path_image=/tmp/back/ci-images
dst_path_image=/srv/ci-images
docker_compose_status="up"
# read the option and store in the variable, $option
while getopts ":s:p:P:t:T:d:D:h:" options; do
    case "${options}" in
        s)
            service_name=${OPTARG}
            echo -e "\U1F4CC Service-Name: $service_name "
            image="$service_name:v1.tar.gz"
            ;;
        t)
            target_server=${OPTARG}
            echo -e "\U1F4CC Deploy $service_name in $target_server "
            ;;
        p)
            src_path_image=${OPTARG}
            echo -e "\U1F4CC src_path_image is $src_path_image on Middle Node(Monitor) "
            ;;
        P)
            dst_path_image=${OPTARG}
            echo -e "\U1F4CC dst_path_image is $dst_path_image On $target_server Node "
            ;;
        d)
            docker_compose_file=${OPTARG}
            echo -e "\U1F4CC Docker-Compose-File: $docker_compose_file "
            ;;
        D)
            docker_compose_status=${OPTARG}
            echo -e "\U1F4CC Docker-Compose-Status: $docker_compose_status "
            ;;
        h)
            health_check_link=${OPTARG}
            echo -e "\U1F4CC Health Check link: $health_check_link "
            ;;
        T)
            status_container=${OPTARG}
            service_name="$service_name"_deploy
            echo -e "$GRN \U1F4CC A test container is launched to ensure that the service is working properly "
            ;;
        *)
            echo -e "\U1F4A1\U2757 You must use options "
            echo -e "\U1F4CC\U2757 s = Service-Name | t = target_server | T = deploy test| p = src_path_image | P = dst_path_image | d = docker_compose_file | D = docker_compose_status | h = health_check "
            exit 1
            ;;
    esac
done
if [ -z "$service_name" ];then
    read -rp " Please enter the Service Name : " service_name
    service_name="$service_name"_deploy
fi

echo -e "#### \U1F4C8 Sending $image \U1F4C8 ####"
# scp "$src_path_image"/"$image" "$target_server":"$dst_path_image"
if scp "$src_path_image"/"$image" "$target_server":"$dst_path_image";
        then
                echo -e "$GRN \U2705 ################# Image Sent Successfully #################\n$NC"
        else
                 echo -e "\n\n$RED\U274C ################# There is a PROBLEM with Sending the image #################\n$NC"
                exit 1
fi

echo -e "#### \U231B Load New Image \U231B  ####"
# ssh "$target_server" -o ConnectTimeout=15 docker load -i "$dst_path_image"/"$image"
if ssh "$target_server" -o ConnectTimeout=15 docker load -i "$dst_path_image"/"$image" ;
        then
                echo -e "$GRN \U2705 ################# Load New Image Successfully #################\n$NC"
        else
                echo -e "\n\n$RED\U274C ################# There is a PROBLEM with Loading the image #################\n$NC"
                exit 1
fi

###### Remove old containers ######
    #echo -e "#### Remove container ####"
    #ssh $target_server -o ConnectTimeout=15 docker rm -f $service_name
    #if [ $? -eq 0 ]
    #        then
    #                echo -e "$GRN################# Remove old Container Successfully #################$NC"
    #        else
    #                echo -e "$RED################# There is a problem, the Container could not be Remove #################$NC"
    #fi
    ######### start new-image ######
if [ "$docker_compose_status" == "up" ]
        then
            echo -e "$GRN \U2705 ################# Starting the container #################\n$NC"
            { { ssh "$target_server" -o ConnectTimeout=15 docker-compose -f /srv/docker-composes/"$docker_compose_file" up -d --force-recreate "$service_name" || \
            ssh "$target_server" -o ConnectTimeout=15 docker compose -f /srv/docker-composes/"$docker_compose_file" up -d --force-recreate "$service_name" ; } && \
            echo -e "$GRN \U2705 ################# The container was launched successfully #################\n$NC" ; } \
            || echo -e  "$RED \U2705 ################# Docker-compose didnt run successfully #################\n$NC" && \
            exit 0 

        else
            echo -e "$GRN \U2705 ################# Image Loaded / The process is over #################\n$NC"
            exit 1
fi

declare -i health_check_counter health_check_success
health_check_counter=0
health_check_success=0

while [ $health_check_counter -lt 1200 ];do

if curl -m 2 -s "$health_check_link" | grep OK ;
    then
        health_check_success=1
        echo -e "$GRN \U2705 ################# Health Check answered health_check_successfully #################\n$NC"
        break
    else
        sleep 10
        health_check_counter=$((health_check_counter+10))

        if [ $health_check_counter == 600 ]
        then
            echo -e "$RED After 10 minutes, the service is still not up, you can view the service log or wait another 10 minutes until the result of the script is determined. \n$NC"
            docker logs --tail 100 "$service_name"
        else
            echo -e "$GRN $health_check_counter Second Passed\n$NC"
        fi

        echo -e "$RED\n\U274C-------------------- $target_server Health check is Offline. -------------------\n$NC"
        echo -e "$GRN--------------------------- Please wite ------------------------------\n$NC"
fi
done

if [ $health_check_success -eq 1 ]
then
        if [ "$status_container" == "testing" ]
        then
            docker rm -f "$service_name"
            echo -e "$GRN \U2705 ################# The Container test was successful and the container was removed #################\n$NC"
        else
            echo -e "$GRN \U2705 ################# The Container is launched #################\n$NC"
        fi
        exit 0
else
        echo -e "$RED \U274C ################# The Container test failed and the service failed to start completely #################\n$NC"
        docker logs --tail 100 "$service_name"
        exit 0
fi