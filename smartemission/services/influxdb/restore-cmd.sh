#!/bin/bash
#
# Restore InfluxDB from local dumpfile.
#

CONTAINER_BACKUP_DIR=/backup/${INFLUXDB_DB}
CONTAINER_DUMP_FILE=/backup/influxdb_${INFLUXDB_DB}_data.tar.gz
INFLUX_CMD="influx -host 127.0.0.1 -port 8086 -database ${INFLUXDB_DB} -username ${INFLUXDB_ADMIN_USER} -password ${INFLUXDB_ADMIN_PASSWORD} -execute "

# On RUNNING Pod/Container
echo "Unpack ${CONTAINER_DUMP_FILE}..."
tar -xzvf ${CONTAINER_DUMP_FILE} -C /backup

# First must delete database otherwise meta restore errors
echo "DROP DATABASE ${INFLUXDB_DB}..."
${INFLUX_CMD} "DROP DATABASE ${INFLUXDB_DB}"

# Do restore
echo "Restore ${INFLUXDB_DB} from ${CONTAINER_BACKUP_DIR} ..."
influxd restore -portable -db ${INFLUXDB_DB} -newdb ${INFLUXDB_DB} ${CONTAINER_BACKUP_DIR}

# Permissions are somehow not set, users should still exist
echo "Restore permissions for users ${INFLUXDB_READ_USER} and ${INFLUXDB_WRITE_USER} ..."
${INFLUX_CMD} "GRANT READ ON ${INFLUXDB_DB} TO ${INFLUXDB_READ_USER}"
${INFLUX_CMD} "GRANT ALL ON ${INFLUXDB_DB} TO ${INFLUXDB_WRITE_USER}"

# Cleanup
echo "Removing unpacked backup in ${CONTAINER_BACKUP_DIR} ..."
rm -rf ${CONTAINER_BACKUP_DIR}
