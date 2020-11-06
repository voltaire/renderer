#!/bin/bash

set -e

mkdir -p /worlds /data
aws s3 cp --no-progress ${BACKUP_TARBALL_URI} /data/world.tar.gz
cd /worlds
tar xf /data/world.tar.gz

SECONDS=0

overviewer.py --config /overviewer_cfg.py

aws cloudwatch put-metric-data --namespace Renderer --metric-name RunDuration --dimensions Runner=${RUNNER_NAME} --value ${SECONDS} --unit Seconds

if [ -n "$DESTINATION_BUCKET_ENDPOINT" ]; then
    ENDPOINT_FLAG="--endpoint=${DESTINATION_BUCKET_ENDPOINT}"
fi

if [ -n "$DESTINATION_ACCESS_KEY_ID" ] && [ -n "$DESTINATION_SECRET_ACCESS_KEY" ]; then
    AWS_ACCESS_KEY_ID=${DESTINATION_ACCESS_KEY_ID}
    AWS_SECRET_ACCESS_KEY=${DESTINATION_SECRET_ACCESS_KEY}
fi

aws s3 sync ${ENDPOINT_FLAG} --acl 'public-read' --delete /output/ ${DESTINATION_BUCKET_URI}

curl -H 'Content-Type: application/json' -XPOST ${DISCORD_WEBHOOK_URL} -d "{\"content\": \"new map rendered for ${BACKUP_TARBALL_URI}. See https://map.tonkat.su/\"}"