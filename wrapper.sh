#!/bin/bash

set -e

mkdir -p /worlds /data
aws s3 cp ${BACKUP_TARBALL_URI} /data/world.tar.gz
cd /worlds
tar xvf /data/world.tar.gz
overviewer.py --config /overviewer_cfg.py
aws s3 sync --storage-class ONEZONE_IA --delete /output/ ${MAP_OUTPUT_URI}