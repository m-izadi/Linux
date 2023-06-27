#!/bin/bash
delivery_path_deploy=/mnt/share/graphhopper/deploy/gh
delivery_path=/mnt/share/graphhopper
delivery_back_path=/mnt/share/graphhopper/back
here_path=/tmp/back/graphhopper/bin/
conf_path=/tmp/back/graphhopper/conf/
conf_name=config-example.yml
jar_name=graphhopper-web-6.0-SNAPSHOT.jar
echo "--------------------------# Start graphhopper deploy #------------------------------"
echo -e "\n\n"
#echo "------# Create backup file in nodes... #----------"
#ssh -o ConnectTimeout=15 -o StrictHostKeyChecking=no support@192.168.19.15 rsync -avzh --exclude 'back' --exclude 'logs' $delivery_path/* $delivery_back_path 
#ssh -o ConnectTimeout=15 -o StrictHostKeyChecking=no support@192.168.19.15 rm -rf $delivery_back_path/back
#||ssh -o ConnectTimeout=15 -o StrictHostKeyChecking=no support@192.168.19.15 rsync -avzh $delivery_path/* $delivery_back_path
#||ssh -o ConnectTimeout=15 -o StrictHostKeyChecking=no support@192.168.19.15 rsync -avzh /mnt/share/front/public/public-build/ /mnt/share/front/public/public-bak 

echo "------# Deliver file to nodes-deploy ... #----------"

rsync -avzh --delete-after -e 'ssh -o ConnectTimeout=15 -o StrictHostKeyChecking=no' $here_path/$jar_name support@192.168.19.16:$delivery_path_deploy/$jar_name 
rsync -avzh --delete-after -e 'ssh -o ConnectTimeout=15 -o StrictHostKeyChecking=no' $conf_path/$conf_name support@192.168.19.16:$delivery_path_deploy/$conf_name 
#|| rsync -avzh --delete-after -e 'ssh -o ConnectTimeout=15 -o StrictHostKeyChecking=no' $here_path support@192.168.19.15:$delivery_path
#|| rsync -avzhe 'ssh -o ConnectTimeout=15 -o StrictHostKeyChecking=no' $here_path support@192.168.19.15:$delivery_path



echo "------# Deploying new container-deploy  on node1... #---------"
ssh support@192.168.19.16 -o ConnectTimeout=15 docker rm -f graphhopper-deploy
ssh support@192.168.19.16 -o ConnectTimeout=15 docker-compose -f /mnt/share/graphhopper/deploy/graphhopper-deploy.yml up -d && deploy=node1
result_node1=`echo $?`
if [ $result_node1 -ne 0 ]
then
        if [ $result_node1 -eq 255 ]
        then
                echo -e "\n------#node1 was unreachable... #---------"
                #echo -e "\n------# Deploying new container on node3... #---------"
                #ssh support@192.168.19.15 -o ConnectTimeout=15 docker-compose -f /mnt/share/back/business/business-deploy.yml up -d && deploy=node3
                #if [ $? -ne 0 ]
                #then
                #ssh support@192.168.19.15 -o ConnectTimeout=15 -o StrictHostKeyChecking=no docker-compose -f /mnt/share/front/public/public-deploy.yml -d && deploy=node3
        #else 
                echo -e "\nAll nodes are down...!!!"
                exit 1
                #fi
        else
                echo "Deploy had a problem..."
                exit 1
        fi
fi

case $deploy in
        node1)
                echo -e "\n---# on $deploy testing... #---"
                declare -i counter success
                counter=0
                success=0
                while [ $counter -lt 180 ];do
                curl -m 2 -s 192.168.19.16:7989/health | grep OK
                if [ $? -eq 0 ]
                then
                        success=1
                        echo -e "\n------------# on $deploy deploy-test has been successfully run. #-----------"
                        break
                else
                        sleep 1m
                        counter=$counter+1
                fi
                done
                if [ $success -eq 1 ]
                then
			#echo "------# Create backup file in nodes... #----------"
			#ssh -o ConnectTimeout=15 -o StrictHostKeyChecking=no support@192.168.19.15 rsync -avzh --exclude 'back' --exclude 'logs' --exclude 'deploy' $delivery_path/* $delivery_back_path
			#echo "------# Deliver file to nodes-deploy ... #----------"
			rsync -avzh --delete-after -e 'ssh -o ConnectTimeout=15 -o StrictHostKeyChecking=no' $here_path/$jar_name support@192.168.19.16:$delivery_path/$jar_name
			rsync -avzh --delete-after -e 'ssh -o ConnectTimeout=15 -o StrictHostKeyChecking=no' $conf_path/$conf_name support@192.168.19.16:$delivery_path/$conf_name
                        exit 0
                else 
                        echo -e "\n------------# on $deploy deploy-test has been failed! #-----------"
                        docker logs --tail 400 graphhopper-deploy
                        exit 1
                fi
                ;;

esac