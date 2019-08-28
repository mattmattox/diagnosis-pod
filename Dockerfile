FROM ubuntu:18.04
MAINTAINER cube8021@gmail.com

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -yq --no-install-recommends \
    apt-utils \
    apache2 \
    conntrack \
    top \
    nano \
    sysstat \
    iptables \
    dig \
    nslookup \
    wget \
    curl \
    lynx \
    iputils-ping \
    ca-certificates \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

##Set locales
RUN locale-gen en_US.UTF-8 en_GB.UTF-8 de_DE.UTF-8 es_ES.UTF-8 fr_FR.UTF-8 it_IT.UTF-8 km_KH sv_SE.UTF-8 fi_FI.UTF-8

##Configure Apache
ADD apache.conf /etc/apache2/sites-available/
RUN a2dissite 000-default
RUN a2ensite apache.conf
RUN ln -sf /proc/self/fd/1 /var/log/apache2/access.log && \
    ln -sf /proc/self/fd/1 /var/log/apache2/error.log

ADD index.html /var/www/src

EXPOSE 80
WORKDIR /root
CMD apachectl -D FOREGROUND
