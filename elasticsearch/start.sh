#!/bin/sh

if [ -n "$CLUSTER_NAME" ]; then
    OPTIONS="$OPTIONS -Des.cluster.name=$CLUSTER_NAME"
fi

if [ -n "$NODE_NAME" ]; then
    OPTIONS="$OPTIONS -Des.node.name=$NODE_NAME"
fi

if [ -n "$UNICAST_HOSTS" ]; then
    OPTIONS="$OPTIONS -Des.discovery.zen.ping.unicast.hosts=$UNICAST_HOSTS"
fi

/usr/share/elasticsearch/bin/elasticsearch "$OPTIONS"
