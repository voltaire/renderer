#!/bin/bash

set -e

mkdir -p /worlds /data
aws s3 cp --no-progress ${BACKUP_TARBALL_URI} /data/world.tar.gz
cd /worlds
tar xf /data/world.tar.gz
overviewer.py --config /overviewer_cfg.py

AWS_ACCESS_KEY_ID=${DESTINATION_ACCESS_KEY_ID}
AWS_SECRET_ACCESS_KEY=${DESTINATION_SECRET_ACCESS_KEY}
aws s3 sync --endpoint=${DESTINATION_BUCKET_ENDPOINT} --delete /output/ ${DESTINATION_BUCKET_URI}
curl -H 'Content-Type: application/json' -XPOST ${DISCORD_WEBHOOK_URL} -d '{"content": "NEW MAP NEW MAP NEW MAP BRUH CHECK IT OUT https://map.tonkat.su YOU MIGHT NEED TO CLEAR YOUR CACHE"}'