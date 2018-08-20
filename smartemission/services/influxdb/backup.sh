#!/bin/bash                                                                                                                                                                                                                                                                                             
# Dump InfluxDB and copy dump file to local dir.                                                                                                                                                                                                                                                        
# NB NOT YET TESTED!!

INFLUXDB_DB=smartemission
CONTAINER_NAME=influxdb-0
CONTAINER_BACKUP_DIR=/backup/${INFLUXDB_DB}
CONTAINER_DUMP_FILE=/backup/influxdb_${INFLUXDB_DB}_data.tar.gz

# On RUNNING Pod/Container
kubectl -n collectors exec ${CONTAINER_NAME} -- rm -rf ${CONTAINER_BACKUP_DIR}
kubectl -n collectors exec ${CONTAINER_NAME} -- mkdir -p ${CONTAINER_BACKUP_DIR}
kubectl -n collectors exec ${CONTAINER_NAME} -- influxd backup -database ${INFLUXDB_DB} ${CONTAINER_BACKUP_DIR}
kubectl -n collectors exec ${CONTAINER_NAME} -- tar -cvzf ${CONTAINER_DUMP_FILE} -C /backup ${INFLUXDB_DB}
kubectl cp collectors/${CONTAINER_NAME}:${CONTAINER_DUMP_FILE} .
kubectl -n collectors exec ${CONTAINER_NAME} -- rm -rf ${CONTAINER_BACKUP_DIR} ${CONTAINER_DUMP_FILE}
