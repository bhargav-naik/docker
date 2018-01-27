#!/bin/bash -x

function stop() {
  docker-compose down
  rm -rf ~/work/docker-volumes/hbase
  rm -rf ~/work/docker-volumes/zookeeper
}

function start() {
  mkdir -p ~/work/docker-volumes
  docker-compose up
}

action=$1
case "$action" in
  start)
      start
      ;;
  stop)
      stop
      ;;
  *)
      echo "Usage: $0 {start|stop}" >&2
      exit 1
      ;;
esac