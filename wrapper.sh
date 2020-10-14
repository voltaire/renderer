#!/bin/bash

set -e

mkdir -p /worlds /data
aws s3 cp --no-progress ${BACKUP_TARBALL_URI} /data/world.tar.gz
cd /worlds
tar xf /data/world.tar.gz
overviewer.py --config /overviewer_cfg.py
aws s3 sync --cache-control 'max-age=3600' --delete /output/ ${MAP_OUTPUT_URI}
curl -H 'Content-Type: application/json' -XPOST ${DISCORD_WEBHOOK_URL} -d '{"content": "NEW MAP NEW MAP NEW MAP BRUH CHECK IT OUT https://map.tonkat.su YOU MIGHT NEED TO CLEAR YOUR CACHE"}'