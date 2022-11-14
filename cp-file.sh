#!/bin/bash
file=`ls -t /srv/osm_generator/osm_export/export_data | head -1`
echo $file
ls -t /srv/osm_generator/osm_export/export_data | head -1
rsync -avzhe 'ssh -o StrictHostKeyChecking=no' /srv/osm_generator/osm_export/export_data/"$file" support@192.168.178.30:/etc/nginx/download/