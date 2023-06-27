#!/bin/bash
####################################################
RED="\033[1;31m" # Light Red 
GRN="\033[1;32m" # Light Green
NC='\033[0m' # No Color
####################### OSM Source ##########################
osm_path=/srv/osm_generator/road_export/export_data
osm_name=direction.osm
####################### OSM Destination 
osm_service_path=/data/graphhopper/data
osm_deploy_path=/srv/graphhopper-deploy/data
####################### OSM Backend Car 
# backend_car_path=/mnt/share/osrm/osrm-backend-car/data
backend_car_path=/srv/osrm/osrm-backend-car/data
####################### Cache Backup 
# graphhopper_backup=/data/graphhopper/Backup
####################### Graphhopper Path 
graphhopper_dir=/data/graphhopper
deploy_graphhopper_dir=/data/graphhopper
# graphhopper_dir=/srv/graphhopper
# cache_dir=default-gh
#######################  Graphhoper Yaml File 
# yaml_graphhopper_deploy=/mnt/share/graphhopper/deploy/graphhopper-deploy.yml
yaml_graphhopper_deploy=/srv/graphhopper-deploy/graphhopper-deploy.yml
####################### Health Check 
Deploy_HealthCheck=192.168.178.45:7989/health
node1_HealthCheck=192.168.19.15:8989/health
node2_HealthCheck=192.168.19.16:8989/health
###################### SSH 
ssh_to_local=support@192.168.178.45
ssh_to_node1=support@192.168.178.36
ssh_to_node2=support@192.168.178.37
###################### Container 
Container_Name_Deploy=graphhopper-deploy
Container_Name_1=graphhopper1
Container_Name_2=graphhopper2

echo -e "\n\n"
echo -e "\n\n${GRN} START \n #####################################  $(date +"%T %A %d %B" )  #####################################"
echo -e "\n\n${GRN}###################################################################################"
echo -e "################### GraphHopper Deploy script was executed ########################"
echo -e "###################################################################################${NC}"

# step1
echo -e "\n\n${GRN}###################################################################################"
echo -e "############# Copy OSM file to $osm_deploy_path #################"
echo -e "###################################################################################${NC}"
ssh $ssh_to_local -o ConnectTimeout=15 rsync -Pavzh $osm_path/$osm_name $osm_deploy_path/$osm_name

# step3
echo -e "\n\n${GRN}###################################################################################"
echo -e "##############################  Remove Default-Gh    ##############################"
echo -e "###################################################################################${NC}"
ssh $ssh_to_local -o ConnectTimeout=15 rm -rf $deploy_graphhopper_dir/default-gh/*

# step4
echo -e "\n\n${GRN}###################################################################################"
echo -e "#################   start $Container_Name_Deploy on Deploy    #########################"
echo -e "###################################################################################${NC}"
# ssh $ssh_to_local -o ConnectTimeout=15 docker restart $Container_Name_Deploy && deploy=node1
ssh $ssh_to_local -o ConnectTimeout=15 docker compose -f $yaml_graphhopper_deploy up -d

result_node1=$?
if [ $result_node1 -ne 0 ]
then
        if [ $result_node1 -eq 255 ]
        then
                echo -e "$RED\n------#node1 was unreachable... #---------"
                echo -e "$RED\nAll nodes are down...!!!"
                exit 1
        else
                echo -e "$RED Deploy had a problem..."
                exit 1
        fi
fi

# step 5
echo -e "\n\n${GRN}###################################################################################"
echo -e "#######################   with for Create Cache on Deploy    ######################"
echo -e "###################################################################################${NC}\n"

declare -i counter success
counter=0
success=0
while [ $counter -lt 180 ];do
if curl -m 2 -s $Deploy_HealthCheck | grep OK ;
    then
        success=1
        echo -e "${GRN}\n------------# on $Container_Name_Deploy Container has been successfully run. #-----------"
        break
    else
        echo -e "${GRN} $counter Minutes Passed"
        sleep 1m
        counter=$((counter+1))
        echo -e "$RED\n-------------------- Deploy Health check is Offline. -------------------"
        echo -e "${GRN}----------------------------- Please wite -----------------------------"
fi
done

if [ $success -eq 1 ];then
    echo -e "\n\n${GRN}###################################################################################"
    echo -e "#####################   Deploy Health check is Online    ##########################"
    echo -e "###################################################################################${NC}"
    echo -e "\n\n${GRN}###################################################################################"
    echo -e "################ Copy OSM file to $osm_service_path Node 1   #################"
    echo -e "###################################################################################${NC}"
    ssh $ssh_to_local -o ConnectTimeout=15 rsync -Pavzhe 'ssh -o StrictHostKeyChecking=no' $osm_deploy_path/$osm_name $ssh_to_node1:$osm_service_path/$osm_name

    # echo -e "\n\n${GRN}###################################################################################"
    # echo -e "##############  Create Backup from Node 1 $graphhopper_dir/* ################"
    # echo -e "###################################################################################${NC}"
    # echo -e "${GRN}(--exclude 'back' --exclude 'logs' --exclude 'deploy' --exclude 'Backup-sep-20' --exclude 'Backup' --exclude 'data-deploy') "
    # ssh $ssh_to_node1 -o ConnectTimeout=15 -o StrictHostKeyChecking=no rm -rf $graphhopper_backup/*
    # ssh $ssh_to_node1 -o ConnectTimeout=15 -o StrictHostKeyChecking=no rsync -Pazhe --exclude 'logs'  --exclude 'Backup'  $graphhopper_dir/* $graphhopper_backup/
    echo -e "\n\n${GRN}###################################################################################"
    echo -e "#############################  Move Cache to Node 1  ##############################"
    echo -e "###################################################################################${NC}"
    ssh $ssh_to_local -o ConnectTimeout=15 -o StrictHostKeyChecking=no rsync -avzhe 'ssh -o StrictHostKeyChecking=no' $deploy_graphhopper_dir/default-gh $ssh_to_node1:$graphhopper_dir/
    echo -e "${GRN}###################################################################################"
    echo -e "############################ Restart Graphhopper Node 1    ########################"
    echo -e "###################################################################################${NC}"
    ssh $ssh_to_node1 -o ConnectTimeout=15 docker restart $Container_Name_1
    echo -e "\n\n${GRN}###################################################################################"
    echo -e "############################   Check Node 1 HealthCheck    ########################"
    echo -e "###################################################################################${NC}"

    node1_counter=0
    node1_success=0
    while [ $node1_counter -lt 30 ];do
    if curl -m 2 -s $node1_HealthCheck | grep -i OK ;
        then
            echo -e "\n\n${GRN}###################################################################################"
            echo -e "########################   Node1 Health check is Online    ########################"
            echo -e "###################################################################################${NC}"
            node1_success=1
            break
        else
            echo -e "${GRN} $node1_counter Minutes Passed"
            sleep 1m
            node1_counter=$((node1_counter+1))
            echo -e "$RED\n-------------------- Node1 Health check is Offline. -------------------${NC}"
            echo -e "${GRN}--------------------------- Please wite ------------------------------${NC}"
    fi
    done
    if [ $node1_success -eq 1 ];
        then
    # echo -e "\n\n${GRN}###################################################################################"
    # echo -e "##############  Create Backup from Node 2 $graphhopper_dir/* ################"
    # echo -e "###################################################################################${NC}"
    # echo -e "${GRN}(--exclude 'back' --exclude 'logs' --exclude 'deploy' --exclude 'Backup-sep-20' --exclude 'Backup' --exclude 'data-deploy') "
    # ssh $ssh_to_node2 -o ConnectTimeout=15 -o StrictHostKeyChecking=no rm -rf $graphhopper_backup/*
    # ssh $ssh_to_node2 -o ConnectTimeout=15 -o StrictHostKeyChecking=no rsync -azhe --exclude 'logs'  --exclude 'Backup'  $graphhopper_dir/* $graphhopper_backup/
    echo -e "\n\n${GRN}###################################################################################"
    echo -e "################ Copy OSM file to $osm_service_path Node 2   #################"
    echo -e "###################################################################################${NC}"
    ssh $ssh_to_local -o ConnectTimeout=15 rsync -Pavzhe 'ssh -o StrictHostKeyChecking=no' $osm_deploy_path/$osm_name $ssh_to_node2:$osm_service_path/$osm_name

    echo -e "\n\n${GRN}###################################################################################"
    echo -e "#############################  Move Cache to Node 2 ###############################"
    echo -e "###################################################################################${NC}"
    ssh $ssh_to_local -o ConnectTimeout=15 -o StrictHostKeyChecking=no rsync -avzhe 'ssh -o StrictHostKeyChecking=no' $deploy_graphhopper_dir/default-gh $ssh_to_node2:$graphhopper_dir/
    # ssh $ssh_to_local -o ConnectTimeout=15 -o StrictHostKeyChecking=no "scp $deploy_graphhopper_dir/default-gh $ssh_to_node1:$graphhopper_dir/
            echo -e "\n\n${GRN}###################################################################################"
            echo -e "############################ Restart Graphhopper Node 2    ########################"
            echo -e "###################################################################################${NC}"
            ssh $ssh_to_node2 -o ConnectTimeout=15 docker restart $Container_Name_2
            echo -e "\n\n${GRN}###################################################################################"
            echo -e "##########################   Check Node 2 HealthCheck    ##########################"
            echo -e "###################################################################################${NC}"
            node2_counter=0
            while [ $node2_counter -lt 30 ];do
            if curl -m 2 -s $node2_HealthCheck | grep -i OK ;
            then
            echo -e "\n\n${GRN}###################################################################################"
            echo -e "########################   Node 2 Health check is Online    #######################"
            echo -e "###################################################################################${NC}"
                    break
            else
                    echo -e "${GRN} $node2_counter Minutes Passed${NC}"
                    sleep 1m
                    node2_counter=$((node2_counter+1))
                    echo -e "$RED\n-------------------- Node2 Health check is Offline. -------------------${NC}"
                    echo -e "${GRN}----------------------------- Please wite -----------------------------${NC}"
            fi
            done
            echo -e "\n\n${GRN}###################################################################################"
            echo -e "############## Copy OSM file to /srv/osrm/osrm-backend-car/data ###################"
            echo -e "###################################################################################${NC}"
            ssh $ssh_to_node1 -o ConnectTimeout=15 rsync -Pavzhe --delete-after $osm_service_path/$osm_name $backend_car_path/$osm_name
            echo -e "\n\n${GRN}###################################################################################"
            echo -e "############################  Restart osrm-back-car   #############################"
            echo -e "###################################################################################${NC}"
            # ssh $ssh_to_local -o ConnectTimeout=15 /usr/bin/docker stop osrm-back-car
            ssh $ssh_to_node1 -o ConnectTimeout=15 docker run -t --rm -v "/srv/osrm/osrm-backend-car/data:/data" osrm/osrm-backend:v5.25.0 osrm-extract -p /opt/car.lua /data/direction.osm
            ssh $ssh_to_node1 -o ConnectTimeout=15 docker run -t --rm -v "/srv/osrm/osrm-backend-car/data/:/data" osrm/osrm-backend:v5.25.0 osrm-partition /data/direction.osrm
            ssh $ssh_to_node1 -o ConnectTimeout=15 /usr/bin/docker run -t --rm -v "/srv/osrm/osrm-backend-car/data/:/data" osrm/osrm-backend:v5.25.0  osrm-customize /data/direction.osrm
            # ssh $ssh_to_local -o ConnectTimeout=15 /usr/bin/docker restart osrm-back-car
    else
            echo -e "\n\n$RED###################################################################################"
            echo -e "#########################   Node 1 After 20M Not Running   #######################"
            echo -e "###################################################################################${NC}"
            ssh $ssh_to_node1 -o ConnectTimeout=15 -o StrictHostKeyChecking=no docker logs --tail 100 $Container_Name_1
            exit 1
    fi
else
        echo -e "$RED###########################   Health check is Offline    ###########################${NC}"
        echo -e "$RED\n------------# on $deploy $Container_Name_Deploy Container has been failed! #-----------${NC}"
        ssh $ssh_to_local -o ConnectTimeout=15 -o StrictHostKeyChecking=no docker logs --tail 400 $Container_Name_Deploy
        ssh $ssh_to_local -o ConnectTimeout=15 docker stop $Container_Name_Deploy
        ssh $ssh_to_local -o ConnectTimeout=15 docker rm -f $Container_Name_Deploy
        exit 1
fi

# Delete *_direction.osm from 3 days ago
# Note that if the osm file has not been created in the past 3 days, all the osm files except the main file (direction.osm) will be deleted
# sudo find /opt/gis_tools/osm_export/export_data/*_direction.osm -mtime +3 -type f -delete
ssh $ssh_to_local -o ConnectTimeout=15 docker stop $Container_Name_Deploy
ssh $ssh_to_local -o ConnectTimeout=15 docker rm -f $Container_Name_Deploy
echo -e "############################################################################## END %-40s \n" " \U231B $(date) \U231B"
echo -e "\U2705\U1F44D Bye ${NC}"
