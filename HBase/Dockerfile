FROM bhargavnaik/deb7-java8
MAINTAINER Bhargav Naik <bhargavnaik07@gmail.com>

WORKDIR /home/bhargav

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

# Stargate  8080  / 8085
# Thrift    9090  / 9095
# HMaster   16000 / 16010
# RS        16201 / 16301
EXPOSE 8080 8085 9090 9095 16000 16010 16201 16301

# Copy hbase-site.xml
ADD conf/hbase-site.xml /usr/share/hbase/conf/hbase-site.xml
ADD entrypoint.sh /usr/share/hbase/bin/entrypoint.sh

ENV PATH=$PATH:/usr/share/hbase/bin/
CMD /usr/share/hbase/bin/entrypoint.sh
