#!/bin/bash
#
# Restore InfluxDB from local dumpfile.
#

INFLUXDB_DB=airsenseur
CONTAINER_NAME=dc-airsenseur-0
CONTAINER_DUMP_FILE=/backup/influxdb_${INFLUXDB_DB}_data.tar.gz
NS=collectors

# ETL Process must be as first argument
DUMP_FILE="$1"
if [ "${DUMP_FILE}x" = "x" ];
then
    echo "Error: no dump file specified"
    exit -1
fi

# On RUNNING Pod/Container
kubectl cp restore-cmd.sh ${NS}/${CONTAINER_NAME}:/restore-cmd.sh
kubectl -n ${NS} exec ${CONTAINER_NAME} -- chmod +x /restore-cmd.sh
kubectl cp ${DUMP_FILE} collectors/${CONTAINER_NAME}:${CONTAINER_DUMP_FILE}
kubectl -n ${NS} exec ${CONTAINER_NAME} -- /restore-cmd.sh

# kubectl -n collectors exec ${CONTAINER_NAME} -- rm -rf ${CONTAINER_DUMP_FILE}
