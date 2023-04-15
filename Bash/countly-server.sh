#! /bin/bash
# this script installs docker-ce and docker-compose latest version from stable channel on ubuntu server
# and then installs countly via  docker compose
# script should be run with super user privilleges

### Variables ###
DOCKER_DAEMON=/etc/docker/daemon.json
DOCKER_URL=https://download.docker.com/linux/ubuntu
DOCKER_COMPOSE_URL=https://github.com/docker/compose/releases/download/1.27.4/docker-compose
DOCKER_COMPOSE_DIR=/usr/local/bin/docker-compose
COUNTLY_REPO=https://github.com/Countly/countly-server.git
COUNTLY_DIR=/root/countly-server
DOCKER_KEYRING=/usr/share/keyrings/docker-archive-keyring.gpg
DOCKER_CRED_DIR=/root/.docker

echo "-----------------------------------------------------install requierd packages------------------------------------------------------------"
apt -y update && \   
apt -y upgrade && \
apt -yy install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release # install requierd packages


echo "-----------------------------------------------------------install docker------------------------------------------------------------------"

status=1
while [ $status -ne 0 ]
do
	echo "nameserver 178.22.122.100" > /etc/resolv.conf # set shecan nameservers
	curl -fsSL $DOCKER_URL/gpg | gpg --dearmor -o $DOCKER_KEYRING # add docker repository gpg key
	status=$?
done

echo \
  "deb [arch=amd64 signed-by=$DOCKER_KEYRING] $DOCKER_URL \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null # add docker repository

status=1
while [ $status -ne 0 ]
do
	echo "nameserver 178.22.122.100" > /etc/resolv.conf # set shecan nameservers
	apt -y update && \ 
	apt -y install \
    	    docker-ce \
            docker-ce-cli \
            containerd.io  \
            git #install docker & git
        status=$?
done


status=1
while [ $status -ne 0 ]
do
	echo "nameserver 178.22.122.100" > /etc/resolv.conf # set shecan nameservers
	curl -L "$DOCKER_COMPOSE_URL-$(uname -s)-$(uname -m)" -o $DOCKER_COMPOSE_DIR # install docker-compose binary
	chmod +x $DOCKER_COMPOSE_DIR
	status=$?
done



echo "--------------------------------------------------------build docker images----------------------------------------------------------------"

status=1
while [ $status -ne 0 ]
do
	echo "nameserver 178.22.122.100" > /etc/resolv.conf # set shecan nameservers
	rm -rf $COUNTLY_DIR && cd /root && git clone $COUNTLY_REPO
	status=$?
done
echo "-----------------------------------------------------------Run dockers------------------------------------------------------------------"

status=1
while [ $status -ne 0 ]
do
	cd $COUNTLY_DIR && docker-compose up -d
done	
echo "----------------------------------------------------------------Done-----------------------------------------------------------------------"
