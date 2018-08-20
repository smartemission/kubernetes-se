#!/bin/bash
# Perform tests within container.
#

INFLUXDB_DB=airsenseur
CONTAINER_NAME=dc-airsenseur-0
CONTAINER_BACKUP_DIR=/backup/${INFLUXDB_DB}
CONTAINER_DUMP_FILE=/backup/influxdb_${INFLUXDB_DB}_data.tar.gz
NS=collectors

# On RUNNING Pod/Container
kubectl cp tests.sh ${NS}/${CONTAINER_NAME}:/tests.sh
kubectl -n ${NS} exec ${CONTAINER_NAME} -- chmod +x /tests.sh
kubectl -n ${NS} exec ${CONTAINER_NAME} -- /tests.sh
