#!/bin/bash

/usr/share/hbase/bin/hbase regionserver start > /usr/share/hbase/logs/rs.log 2>&1 &
/usr/share/hbase/bin/hbase master start --localRegionServers=0