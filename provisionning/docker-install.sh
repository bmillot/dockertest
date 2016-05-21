#!/bin/sh
curl -sSL https://get.docker.com/ | sh
sudo usermod -aG docker ubuntu
echo added user to docker group
curl -sSL https://github.com/docker/compose/releases/download/1.7.0/docker-compose-`uname -s`-`uname -m` > ~/docker-compose
chmod +x ~/docker-compose
