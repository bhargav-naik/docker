FROM debian:wheezy
MAINTAINER Bhargav Naik <bhargavnaik07@gmail.com>

LABEL Description="HBase-1.1.2",

ENV DEBIAN_FRONTEND=noninteractive
ENV JAVA_HOME=/usr/lib/jvm/java-8-oracle
WORKDIR /home/bhargav

# Install Java
RUN \
  echo deb http://ftp.us.debian.org/debian/ wheezy main  >> /etc/apt/sources.list && \
  echo deb http://security.debian.org/debian-security wheezy/updates main  >>  /etc/apt/sources.list && \
  echo deb http://ftp.us.debian.org/debian wheezy-backports main  >>  /etc/apt/sources.list && \
  echo deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main >> /etc/apt/sources.list && \
  echo deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main >> /etc/apt/sources.list && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 && \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  apt-get update && \
  apt-get install -y --force-yes oracle-java8-installer && \
  apt-get install -y --force-yes oracle-java8-set-default && \
  apt-get clean

# Install ps, vim
RUN \
  apt-get install -y --force-yes procps && \
  apt-get install -y --force-yes vim

# Download HBase Binary
RUN \
  wget --no-check-certificate https://archive.apache.org/dist/hbase/1.1.2/hbase-1.1.2-bin.tar.gz

# Install HBase
RUN \
  tar -xvzf hbase-1.1.2-bin.tar.gz && \
  mkdir -p /usr/share/hbase/logs && \
  mkdir /data && \
  mv hbase-1.1.2/* /usr/share/hbase/ && \
  rm -rf hbase-1.1.2 && rm -f hbase-1.1.2-bin.tar.gz

# ZK        2181
# Stargate  8080  / 8085
# Thrift    9090  / 9095
# HMaster   16000 / 16010
# RS        16201 / 16301
EXPOSE 2181 8080 8085 9090 9095 16000 16010 16201 16301

# Copy hbase-site.xml
ADD conf/hbase-site.xml /usr/share/hbase/conf/hbase-site.xml
ADD entrypoint.sh /usr/share/hbase/bin/entrypoint.sh

ENV PATH=$PATH:/usr/share/hbase/bin/
CMD /usr/share/hbase/bin/entrypoint.sh
