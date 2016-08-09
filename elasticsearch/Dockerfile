FROM debian:wheezy

MAINTAINER Bertrand Millot <bmillot@20minutes.fr>

# Install Java 7, elasticsearch 1.6.2
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y -q wget openjdk-7-jre-headless \
    && wget -q https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.6.2.deb -O /tmp/elasticsearch.deb \
    && dpkg -i /tmp/elasticsearch.deb \
    && rm -f /tmp/elasticsearch.deb

# Install elasticsearch plugins head & kopf
RUN /usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head \
    && /usr/share/elasticsearch/bin/plugin install lmenezes/elasticsearch-kopf/1.0

EXPOSE 9200

#ENTRYPOINT ["/usr/share/elasticsearch/bin/elasticsearch"]
