#!/bin/bash
#
# Restore InfluxDB from local dumpfile.
#

CONTAINER_BACKUP_DIR=/backup/${INFLUXDB_DB}
CONTAINER_DUMP_FILE=/backup/influxdb_${INFLUXDB_DB}_data.tar.gz

# On RUNNING Pod/Container
tar -xzvf ${CONTAINER_DUMP_FILE} -C /backup

# First must delete database otherwise meta restore errors
curl -G 'http://localhost:8086/query?pretty=true' -u ${INFLUXDB_ADMIN_USER}:${INFLUXDB_ADMIN_PASSWORD} --data-urlencode db=${INFLUXDB_DB} --data-urlencode q="DROP DATABASE ${INFLUXDB_DB}"

influxd restore -portable -db ${INFLUXDB_DB} -newdb ${INFLUXDB_DB} ${CONTAINER_BACKUP_DIR}

rm -rf ${CONTAINER_BACKUP_DIR}
