#!/bin/sh

# Mount database ebs
sudo mkdir /mnt/ebs-datastore
sudo mount /dev/xvdf /mnt/ebs-datastore

# Login into private aws ecr
eval "$(aws ecr get-login)"

# Provision docker containers
cd /tmp/
sudo docker-compose up -d
