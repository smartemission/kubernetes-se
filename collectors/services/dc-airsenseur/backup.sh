#!/bin/bash
# Dump InfluxDB and copy dump file to local dir.
#

INFLUXDB_DB=airsenseur
CONTAINER_BACKUP_DIR=/backup/${INFLUXDB_DB}
CONTAINER_NAME=dc-airsenseur-0
CONTAINER_DUMP_FILE=/backup/influxdb_${INFLUXDB_DB}_data.tar.gz
NS=collectors

# On RUNNING Pod/Container
kubectl cp backup-cmd.sh ${NS}/${CONTAINER_NAME}:/backup-cmd.sh
kubectl -n ${NS} exec ${CONTAINER_NAME} -- chmod +x /backup-cmd.sh
kubectl -n ${NS} exec ${CONTAINER_NAME} -- /backup-cmd.sh
kubectl cp ${NS}/${CONTAINER_NAME}:${CONTAINER_DUMP_FILE} .
# kubectl -n ${NS exec ${CONTAINER_NAME} -- rm -rf ${CONTAINER_BACKUP_DIR} ${CONTAINER_DUMP_FILE}
