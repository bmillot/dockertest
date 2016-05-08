#!/bin/bash

docker-machine create --driver amazonec2 --amazonec2-region eu-central-1 aws-sandbox
eval "$(docker-machine env aws-sandbox)"
docker run --name mysql -e MYSQL_ROOT_PASSWORD=password -d mysql:latest
docker run --name elasticsearch -d elasticsearch:latest
docker run --name redis -d redis:latest
docker run --name apache2 --link mysql:mysql --link elasticsearch:elasticsearch --link redis:redis -d -p 80:80 bmillot/apache2