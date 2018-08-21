#!/bin/bash
#
# Dump InfluxDB DB, to be executed within container.
#
# INFLUXDB_DB env var is set by container

CONTAINER_BACKUP_DIR=/backup/${INFLUXDB_DB}
CONTAINER_DUMP_FILE=/backup/influxdb_${INFLUXDB_DB}_data.tar.gz

# Init backup target dir
rm -rf ${CONTAINER_BACKUP_DIR}
mkdir -p ${CONTAINER_BACKUP_DIR}

# Do backup
influxd backup -portable -database ${INFLUXDB_DB} ${CONTAINER_BACKUP_DIR}

# Pack backup into tar.gz
tar -cvzf ${CONTAINER_DUMP_FILE} -C /backup ${INFLUXDB_DB}

# Cleanup
rm -rf ${CONTAINER_BACKUP_DIR}
