#!/bin/bash
file=`ls -t /opt/osm_generator/osm_export/export_data/| head -1`
echo $file
echo "################# Start Transfer File #################"
ssh support@192.168.178.45 -o ConnectTimeout=15 rsync -avzhe 'ssh -o StrictHostKeyChecking=no' /srv/osm_generator/osm_export/export_data/$file support@192.168.178.30:/etc/nginx/download/