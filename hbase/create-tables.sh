#!/bin/bash

if [[ -z "$HBASE_CREATE_TABLES" ]]; then
    echo "HBASE_CREATE_TABLES env not supplied"
    exit 0
fi

if [[ ! -f "$HBASE_CREATE_TABLES" ]]; then 
    echo "$HBASE_CREATE_TABLES file doesn't exists"
    exit 1
fi

echo $HBASE_CREATE_TABLES

echo "######## waiting for HBase to come up"
sleep 20
# TODO:: check if hbase is up

function generate_create_command()
{
  create_command="create '$1'"
  cfs=$2
  for cf in ${cfs//,/ }
  do
     create_command=$create_command", {NAME => '${cf}', TTL => '604800', COMPRESSION => 'GZ'}"
  done
  echo $create_command
}

while IFS=: read -r table_name columnfamilies
do
    hbase_command=`generate_create_command $table_name $columnfamilies`
    echo $hbase_command | hbase shell &
done < $HBASE_CREATE_TABLES

wait