FROM debian:jessie

MAINTAINER Bertrand Millot <bmillot@20minutes.fr>

# Install Varnish 4.1
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y -q apt-transport-https curl \
    && curl https://repo.varnish-cache.org/GPG-key.txt | apt-key add - \
    && echo "deb https://repo.varnish-cache.org/debian/ jessie varnish-4.1" >> /etc/apt/sources.list.d/varnish-cache.list \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y -q varnish

ENV VCL_CONFIG /etc/varnish/default.vcl
ENV CACHE_SIZE 64m
ENV VARNISHD_PARAMS -p default_ttl=3600 -p default_grace=3600

ADD varnish.sh /varnish.sh
CMD /varnish.sh

EXPOSE 80

#CMD ["exec" "varnishd" "-F" "-f" "/etc/varnish/default.vcl"]
#ENTRYPOINT ["/usr/sbin/varnishd" "-F" "-f" "/etc/varnish/default.vcl"]
