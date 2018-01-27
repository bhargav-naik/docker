FROM debian:wheezy
MAINTAINER Bhargav Naik <bhargavnaik07@gmail.com>
LABEL Description="deb7-java8",

ENV DEBIAN_FRONTEND=noninteractive
ENV JAVA_HOME=/usr/lib/jvm/java-8-oracle

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
  rm -rf /var/cache/oracle-jdk8-installer
  
# Install ps, vim
RUN \
  apt-get install -y --force-yes procps && \
  apt-get install -y --force-yes vim && \
  apt-get clean 

