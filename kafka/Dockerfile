FROM bhargavnaik/deb7-java8
MAINTAINER Bhargav Naik <bhargavnaik07@gmail.com>

# The Scala 2.12 build is currently recommended by the project.
ENV KAFKA_VERSION=0.10.2.1 KAFKA_SCALA_VERSION=2.12 JMX_PORT=7203
ENV KAFKA_RELEASE_ARCHIVE kafka_${KAFKA_SCALA_VERSION}-${KAFKA_VERSION}.tgz
ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir /kafka /data

RUN \
 apt-get update && \
 apt-get install -y ca-certificates

WORKDIR /tmp
    
# Download Kafka binary distribution
ADD http://www.us.apache.org/dist/kafka/${KAFKA_VERSION}/${KAFKA_RELEASE_ARCHIVE} /tmp/
ADD http://www.us.apache.org/dist/kafka/${KAFKA_VERSION}/${KAFKA_RELEASE_ARCHIVE}.md5 /tmp/

# Check artifact digest integrity
RUN echo VERIFY CHECKSUM: && \
  gpg --print-md MD5 ${KAFKA_RELEASE_ARCHIVE} 2>/dev/null && \
  cat ${KAFKA_RELEASE_ARCHIVE}.md5

# Install Kafka to /kafka
RUN \
  tar -zx -C /kafka --strip-components=1 -f ${KAFKA_RELEASE_ARCHIVE} && \
  rm -rf kafka_*

ADD config /kafka/config
ADD start.sh /start.sh
ADD create-topics.sh /create-topics.sh

# Set up a user to run Kafka
RUN \
 groupadd kafka && \
 useradd -d /kafka -g kafka -s /bin/false kafka && \
 chown -R kafka:kafka /kafka /data && \
 chmod 755 /start.sh && \
 chmod 755 /create-topics.sh

USER kafka
ENV PATH /kafka/bin:$PATH

WORKDIR /kafka

# broker, jmx
EXPOSE 9092 7203
VOLUME [ "/data"]

CMD ["/start.sh"]
