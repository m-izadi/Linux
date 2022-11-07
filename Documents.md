# Docker Command
    sudo docker-compose -f graphhopper.yml up -d
    sudo docker logs -f -n200 9971c7991f43
    
    sudo docker save -o graphhopper:4.2.tar graphhopper
    sudo docker pull http://registry.local:5002/backend/java_run:11.0.11-jre-slim-buster
    sudo docker image load -i java_run:11.0.11-jre-slim-buster.tar
    sudo docker network create gh
    sudo docker rm -f 475e710ccdbf 475e710ccdbf
    sudo docker top 4d40a4f86500
    docker image tag nexus.local:5002/routaa/gis-tools:new nexus.local:5002/routaa/gis-tools:1
    docker image tag gis-tools:1.1 gis-tools:back
    docker commit suspicious_dirac gis-tools:1.7

    host@host:~$ curl -i -s --unix-socket /var/run/docker.sock -X GET http://localhost/containers/4/top
        HTTP/1.1 200 OK
....
Docker_Hub Matin: http://192.168.7.215:8081/  
# Get-SetFacl
    sudo getfacl /srv/osrm/osrm-backend-car/data/
    sudo setfacl -Rm u:support:rwx /srv/osrm/osrm-backend-car/data/
    sudo setfacl -Rm u:support:rwx /srv/graphhopper/default-gh

# strace -e %net,read,write  docker ps
    The main objects available through the API are containers, images, networks, and volumes plus other utilities related to Docker swarm. The format pattern to retrieve and manipulate these objects generally has the following form <object>/<id>/<command>. In the next example, we retrieve the list of processes in one of the containers currently running on the host (equivalent to docker top 4d40a4f86500):

# RSync
sending incremental file list

# DD
sudo dd if=/home/tito/Downloads/Persepolis/Compressed/VMware-VMvisor-Installer-7.0U1c-17325551.x86_64.iso of=/dev/sdc bs=1M status=progress
sudo cfdisk /dev/sdb

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



# Vim
    sudo permision in vim
        :w !sudo tee %

# Note
    for add tag & version / dar berozresan piyade sazi shode roy rottaa ham bayad piyade beshe / roy git ham bayad config beshe / dar moredesh khonde shavad
    semantic versioning



# delete old file
    find /var/log/journal/39fe8277af704ba6b727862fd8d56374/ -type f -mtime +60 -print > deadfiles
    rm -rf `cat deadfiles`


# ReadMe Sample Config
## Libs

- [X] SMS Panel (Kavenegar)
- [X] Serilog
- [X] Sentry
- [X] AutoMapper
- [X] Common Utilities
- [X] Swagger
- [X] RestSharp