# Docker Command
    sudo docker-compose -f graphhopper.yml up -d
    sudo docker logs -f -n200 9971c7991f43
    
    sudo docker save -o graphhopper:4.2.tar graphhopper
    sudo docker pull http://registry.local:5002/backend/java_run:11.0.11-jre-slim-buster
    sudo docker image load -i java_run:11.0.11-jre-slim-buster.tar
    sudo docker network create gh
    sudo docker rm -f 475e710ccdbf 475e710ccdbf
    sudo docker top 4d40a4f86500

    host@host:~$ curl -i -s --unix-socket /var/run/docker.sock -X GET http://localhost/containers/4/top
        HTTP/1.1 200 OK

Docker_Hub Matin: http://192.168.7.215:8081/  
# Get-SetFacl
    sudo getfacl /srv/osrm/osrm-backend-car/data/
    sudo setfacl -Rm u:support:rwx /srv/osrm/osrm-backend-car/data/
    sudo setfacl -Rm u:support:rwx /srv/graphhopper/default-gh

 sudo setfacl -Rm u:arian:rwx /srv
 sudo deluser iman sudo



# strace -e %net,read,write  docker ps
    The main objects available through the API are containers, images, networks, and volumes plus other utilities related to Docker swarm. The format pattern to retrieve and manipulate these objects generally has the following form <object>/<id>/<command>. In the next example, we retrieve the list of processes in one of the containers currently running on the host (equivalent to docker top 4d40a4f86500):

# RSync
    sending incremental file list
    rsync -avzh /tmp/map_2022_09_18_08_43_PM.sql  support@192.168.178.5:/tmp/
# DD
    sudo dd if=/home/tito/Downloads/Persepolis/Compressed/VMware-VMvisor-Installer-7.0U1c-17325551.x86_64.iso of=/dev/sdc bs=1M status=progress
    sudo cfdisk /dev/sdb

# Scan Hard Disk 
    sudo ncdu -x /

# Openresty Mode Secure Config

Connect to 192.168.7.16

    # sudo vim /etc/openresty/nginx/modsec/coreruleset-3.3.2/rules/REQUEST-900-EXCLUSION-RULES-BEFORE-CRS.conf

From Rest http://192.168.7.16/helm/api/admin/poi/categories copy uri(/helm/api/admin/poi/categories) and Search in the file if sample exist , **duplicate the line** , **add new rest** and reload service
elif find **Block ID** from log (tac /var/log/modsec_audit.log | less) search helm/api/admin/poi/categories and status code 403 and enter to REQUEST-900-EXCLUSION-RULES-BEFORE-CRS.conf

    # tac /var/log/modsec_audit.log
    # tac /var/log/modsec_audit.log | grep "member/social-accounts/4005" and get id
    or
    # tail -f /var/log/modsec_audit.log
    # sudo openresty -t


# SSH Jump
 ssh -v -N script@192.168.178.36 -J script@185.13.228.101:2223
 ssh -v -J aldo@185.13.228.101:2223 aldo@192.168.178.36:22
 ssh -f -N support@185.13.228.101 -p 2223 -L 8081:192.168.178.33:8080

 scp -P 2223 support@185.13.228.101:~/Izadi/* .


# Vim
    sudo permision in vim
        :w !sudo tee %

# Note
    for add tag & version / dar berozresan piyade sazi shode roy rottaa ham bayad piyade beshe / roy git ham bayad config beshe / dar moredesh khonde shavad
    semantic versioning

# Mount Partition / Disk 
    fusermount -uz /mnt/share
    sudo umount /mnt/share
    sudo mount -a
    fusermount -uz /mnt/share && umount /mnt/share && mount -a

# Interface ip show
ip -br -c a

# SSH Tunneling
ssh -f -N aldo@185.13.228.101 -p 2223 -L 8085:192.168.178.36:8081




# ReadMe Sample Config
## Libs

- [X] SMS Panel (Kavenegar)
- [X] Serilog
- [X] Sentry
- [X] AutoMapper
- [X] Common Utilities
- [X] Swagger
- [X] RestSharp

# LOGS
sudo docker logs -n5000 geowebcache1 2>&1 | grep Truncated




ip -br -c a

# PSQL Dump
    pg_dump --file "/tmp/"map_$(date +"%Y_%m_%d_%I_%M_%p")".sql" --host 192.168.178.38 --username "postgres" --role "postgres" --format=c --blobs --encoding "UTF8" "map"


pg_dump -h 192.168.178.37 -p 5432 -U postgres -F c -b -v -f ./platform platform
pg_dump -h 192.168.178.36 -p 5432 -U postgres -F c -b -v -f ./porte.sql porte
pg_dump -h 192.168.178.38 -p 5432 -U postgres -F c -b -v -f ./gwc.sql gwc
pg_dump -h 192.168.178.38 -p 5432 -U postgres -F c -b -v -f ./map.sql map


scp support@192.168.178.37:/srv/db/postgres-porte/backups/porte-sep-18.sql
scp support@192.168.178.36:/srv/db/postgres-platform/backups/platform.sql
scp support@192.168.178.38:~/gwc-3.sql


scp -P2223 support@185.13.228.101:/home/support/PG-Backup/porte-sep-18.sql .
scp -P2223 support@185.13.228.101:/home/support/PG-Backup/platform.sql .
scp -P2223 support@185.13.228.101:/home/support/PG-Backup/gwc-3.sql .
scp -P2223 support@185.13.228.101:/home/support/PG-Backup/map.sql .

scp -P2223 /home/tito/Downloads/sprint/sprite/* support@185.13.228.101:~/sprint-test


pg_restore -h localhost -p 5432 -U postgres -d platform ~/platform.sql
create database ;
pg_restore -h localhost -p 5432 -U postgres -d porte ~/porte-sep-18.sql



# Icon Path
    /mnt/share/Routaa/routaa-app/files/action-button/icon/
support@rt-node3:/mnt/share/Routaa/routaa-app/files/action-button/icon
izadi@rt-staging-node3:/mnt/share/Routaa/map-helm/files/docs/cartography-theme
izadi@rt-staging-node3:/data/brick1/back/config-server/configs/ms-map-helm/stage/application.yaml




# Gluster

    sudo systemctl status gluster-ta-volume.service
    sudo systemctl status glusterfssharedstorage.service
    sudo systemctl status glusterd.service
    sudo systemctl status glusterd.service
    sudo gluster --help
    sudo gluster volume --help
    sudo gluster volume
    sudo gluster volume --print-logdir
    ls /var/log/glusterfs
    cat /var/log/glusterfs/bricks/data-brick1.log
    sudo cat /var/log/glusterfs/bricks/data-brick1.log
    sudo gluster info
    sudo gluster help
    sudo gluster volume list
    cd /etc/glusterfs/
    vim glusterd.vol
    history | grep gluster



# My ip
    # curl https://ipv4.icanhazip.com/





alter table traffic_pre_update 
add column congestion int