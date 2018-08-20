#!/bin/bash

echo "Executing for ${INFLUXDB_READ_USER}:${INFLUXDB_READ_PASSWORD}"

URL="http://localhost:8086/query?pretty=true"
CREDS="${INFLUXDB_READ_USER}:${INFLUXDB_READ_USER_PASSWORD}"

MEASUREMENTS="ASE_NL_01 ASE_NL_0 ASE_NL_03 ASE_NL_04 ASE_NL_05"
for MEAS in ${MEASUREMENTS}
do
echo "MEASU=${MEAS}"
curl -s -G http://localhost:8086/query?pretty=true -u ${CREDS}  --data-urlencode db=${INFLUXDB_DB} --data-urlencode q="select * from ASE_NL_01 limit 1"
done
