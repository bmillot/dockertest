#!/bin/bash

docker-machine create --driver amazonec2 --amazonec2-region eu-west-1 aws-sandbox
eval "$(docker-machine env aws-sandbox)"
docker run --name mysql -e MYSQL_ROOT_PASSWORD=password -d mysql:latest
docker run --name elasticsearch -d elasticsearch:latest
docker run --name redis -d redis:latest
docker run --name apache2 --link mysql:mysql --link elasticsearch:elasticsearch --link redis:redis -d -p 80:80 bmillot/apache2
docker run --name elasticsearch-01a -d -p 9200:9200 bmillot/elasticsearch /usr/share/elasticsearch/bin/elasticsearch -Des.config=/etc/elasticsearch/elasticsearch.1.yml
docker run --name elasticsearch-01b --link elasticsearch-01a:node01 -d -p 9201:9200 bmillot/elasticsearch /usr/share/elasticsearch/bin/elasticsearch -Des.config=/etc/elasticsearch/elasticsearch.2.yml
docker run --name elasticsearch-01c --link elasticsearch-01a:node01 -d -p 9202:9200 bmillot/elasticsearch /usr/share/elasticsearch/bin/elasticsearch -Des.config=/etc/elasticsearch/elasticsearch.3.yml

docker run --name elasticsearch-01a -d -p 9200:9200 bmillot/elasticsearch /usr/share/elasticsearch/bin/elasticsearch -Des.cluster.name=20mn.local.search -Des.node.name=20mn.local.search-01a
docker run --name elasticsearch-01b --link elasticsearch-01a:node01 -d bmillot/elasticsearch /usr/share/elasticsearch/bin/elasticsearch -Des.cluster.name=20mn.local.search -Des.node.name=20mn.local.search-01b -Des.discovery.zen.ping.unicast.hosts=node01
docker run --name elasticsearch-01c --link elasticsearch-01a:node01 -d bmillot/elasticsearch /usr/share/elasticsearch/bin/elasticsearch -Des.cluster.name=20mn.local.search -Des.node.name=20mn.local.search-01c -Des.discovery.zen.ping.unicast.hosts=node01

docker run --name elasticsearch-01a -d -p 9200:9200 -e CLUSTER_NAME=20mn.local.search -e NODE_NAME=20mn.local.search-01a bmillot/elasticsearch
docker run --name elasticsearch-01b --link elasticsearch-01a:node01 -d -p 9201:9200 -e CLUSTER_NAME=20mn.local.search -e NODE_NAME=20mn.local.search-01b -e UNICAST_HOSTS=node01 bmillot/elasticsearch
docker run --name elasticsearch-01c --link elasticsearch-01a:node01 -d -p 9202:9200 -e CLUSTER_NAME=20mn.local.search -e NODE_NAME=20mn.local.search-01c -e UNICAST_HOSTS=node01 bmillot/elasticsearch
