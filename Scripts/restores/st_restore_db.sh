#!/bin/bash

exec >> /var/log/database/restore.log 2>&1

databases="porte gwc map platform-back" # (platform) is commented for developers use case.
compose_path="/srv/docker-composes/postgresql-compose.yml"
RED="\e[31m" ; GRN="\e[32m" ; YLW="\e[33m" ; END="\e[0m"



func_restore () {
    #Making sure that theres no connection to the database before restoring into it, and after restoring, just to be on the safe side, we allow the connections connections again.
  echo -e "$GRN----> Disconnecting and also deactivating any connections to the $db database.$END" ; \
  docker exec -i "$container" psql -U postgres -d postgres -c "UPDATE pg_database SET datallowconn=false WHERE datname='$datname'" && \
  docker exec -i "$container" psql -U postgres -d postgres -c "SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = '$datname' AND pid <> pg_backend_pid()" && \
  
  echo -e "$GRN----> Restoring the $db dump-file. ### Started in : $(date "+%Y/%m/%d %H:%M")$END" ; \
  docker exec -i --user postgres "$container" pg_restore --no-owner --dbname postgres -c --create "$dump_path" >>/var/log/database/restore-exec.log && \
  echo -e "$GRN----> Restoring has been done. ### Ended in : $(date "+%Y/%m/%d %H:%M")$END" ; \
  
  docker exec -i "$container" psql -U postgres -d postgres -c "UPDATE pg_database SET datallowconn=true WHERE datname='$datname'" && \
  echo -e "$GRN----> Connection brought back to default state just in case.$END"
}



echo -e "$GRN################################$END Tasks Started in : $YLW$(date "+%Y/%m/%d %H:%M") $GRN###################################$END"

for db in $databases ; do

filename=$(ssh -p 2223 support@185.13.228.101 find /data/db-backup-daily/"$db" -type f 2> /dev/null|sort -nr|head -1) #finding the most recent file if exists.
dest="/srv/$db/backups" #the path where its being copied to.

{
    [ -n "$filename" ] && \
        {
            echo -e "$GRN----------> File founded. Copying the $db dump-file to $dest ...$END" ; \
            {
                scp -P 2223 support@185.13.228.101:"$filename" "$dest" && echo -e "$GRN----------> Done copying over.$END" ;
            } || \
            {
                echo -e "$RED----------> Copying failed !!!$END" && continue ;
            } ;
        } || \
    {
        echo -e "$RED----------> Couldnt find any dump files. Continuing to the next database.$END" && continue ;
    } ;
} && \
echo -e "$GRN################## Now trying to restore $db dump file into its database.$END" ;
{
    dump_name=$(find /srv/"$db"/backups -mindepth 1 -printf "%f\n"| sort -nr | head -1)
    case $db in  #Assigning the variables bellow depending on the database name in the loop.
      gwc) container="db_gwc_map1" ; dump_path="/opt/gwc/backups/$dump_name" ; datname="gwc" ;;
      map) container="db_gwc_map1" ; dump_path="/opt/map/backups/$dump_name" ; datname="map" ;;
      porte) container="db_porte1" ; dump_path="/opt/backups/$dump_name" ; datname="porte" ;;
      platform) container="db_platform1" ; dump_path="/opt/backups/$dump_name" ; datname="platform" ;;
      platform-back) container="db_platform_back1" ; dump_path="/opt/backups/$dump_name" ; datname="platform" ;;
    esac ;
    
    {
        running=$(docker ps --format '{{.Names}}'|grep -i "$container") #Checking whether if its container is running or if not, starting it from the docker compose file. 
        {
            [ -z "$running" ] && \
                {
                    {
                        echo -e "$YLW----> The container $container isnt running, trying to start it.$END" ; \
                        docker compose -f "$compose_path" up -d "$container" && sleep 2m ;
                    } || \
                    echo -e "$RED----> The docker didnt started properly. Skipping to the next database.$END"; continue ;
                } ; \
            {
                func_restore && rm -f /srv/"$db"/backups/* && echo -e "$GRN----> Done removing $db dump-files from local host.$END\n" ;
            } ;
        } ;
    } ;
}

done

echo -e "$GRN################################$END Tasks Ended in : $YLW$(date "+%Y/%m/%d %H:%M") $GRN###################################$END\n"
