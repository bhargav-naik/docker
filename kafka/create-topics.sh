#!/bin/bash

if [[ -z "$KAFKA_CREATE_TOPICS" ]]; then
    echo "KAFKA_CREATE_TOPICS env not supplied"
    exit 0
fi

if [[ ! -f "$KAFKA_CREATE_TOPICS" ]]; then 
    echo "Create topic file doesn't exist"
    exit 1
fi

echo $KAFKA_CREATE_TOPICS

echo "######## waiting for kafka to come up"
# TODO:: check if the kafka is up before running create topics
sleep 10

unset JMX_PORT

while IFS=: read -r topic_name partitions replications
do
    echo "######## creating topic $topic_name $partitions $replications"
    /kafka/bin/kafka-topics.sh --create \
    --zookeeper zk:2181/kafka \
    --topic "$topic_name" \
    --replication-factor $replications \
    --partitions $partitions --if-not-exists &
done < $KAFKA_CREATE_TOPICS

wait
