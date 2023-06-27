#!/bin/bash

#####################  <((((((((((((  copying mbtiles to tileserver  ))))))))))))>  #####################

exec >> /var/log/mbtiles/mbtile_copy.log 2>&1

### =====> first we unset the tile_node variable to be clean before starting.

unset tile_node

### =====> searching for tileservers nodes.

tile_ip="36 37"

echo -e "################# starting the tasks.  $(date) ####################"
for ip in $tile_ip
do

tileservers=$(ssh dev@172.16.178."$ip" docker ps --format '{{.Names}}'|grep -i tileserver) ; \
[[ -n $tileservers ]] && tile_node+=" $ip" && echo -e "tileserver node found on 172.16.178.$ip.\n" || \
echo -e "no tileservers found on node 172.16.178.$ip !!\n"

done
### =====> the variable `tile_node` is what contains the last ip addresses, so that the variable that should be used.


mbtiles=$*

### =====> checking if the containers are exited and then copy its content to the destination.

for tile in $mbtiles
do

container=$(docker inspect mbtile_"$tile" --format='{{ json .State.Running }}') && \
[[ $container == false ]] && echo -e "the $tile container is stopped, we can copy the file safely.\n-------" && \

  for node in $tile_node
  do
  
  echo -e "### copying $tile file to 172.16.178.$node.\n"; \
  scp /data/tilesever/"$tile"/static_"$tile".mbtile dev@172.16.178."$node":/data/tileserver/"$tile" && \
  echo -e "### copy file to 172.16.178.$node has been done.\n-------" || echo -e "### copying didnt succeed !!\n-------"
  
  done
done

### =====> restarting the tileserver containers.

for tileserver_ip in $tile_node
do

echo -e "===> restarting the tileservers to read the new files.\n"
ssh dev@172.16.178."$tileserver_ip" docker compose -f /srv/docker-composes/tileserver.yml up -d --force-recreate && \
echo -e "===> restarted successfully.\n" || echo -e "===> tileserver could not be restarted.\n"; sleep 1m

done
echo -e "################# tasks has been done.  $(date) ####################"