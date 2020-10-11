#!/bin/bash

set -e

mkdir -p /worlds /data
aws s3 cp ${BACKUP_TARBALL_URI} /data/world.tar.gz
cd /worlds
tar xvf /data/world.tar.gz

rm -rf pumpcraft_the_end/DIM1/DIM1
rm -rf pumpcraft_the_end/DIM1/{level.dat,level.dat_old,session.lock,uid.dat}
rm -rf pumpcraft_nether/DIM-1/DIM-1
rm -rf pumpcraft_nether/DIM-1/{level.dat,level.dat_old,session.lock,uid.dat}

overviewer.py --config /overviewer_cfg.py
aws s3 sync --storage-class ONEZONE_IA --cache-control 'max-age=3600' --delete /output/ ${MAP_OUTPUT_URI}
curl -H 'Content-Type: application/json' -XPOST ${DISCORD_WEBHOOK_URL} -d '{"content": "NEW MAP NEW MAP NEW MAP BRUH CHECK IT OUT https://map.tonkat.su YOU MIGHT NEED TO CLEAR YOUR CACHE"}'