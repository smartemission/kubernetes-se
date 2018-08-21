#!/bin/bash
#
# Restore InfluxDB from local dumpfile.
#

# Shorthand func to call InfluxDB REST Query API
function query() {
  QUERY="${@}"
  echo "query: ${QUERY}"

  # replace all blanks http://stackoverflow.com/questions/5928156/replace-a-space-with-a-period-in-bash
  # Basically urlencoding.
  QUERY=${QUERY// /%20}

  # Invoke curl to local InfluxDB instance to execute the query/command
  curl \
   -s -u ${INFLUXDB_ADMIN_USER}:${INFLUXDB_ADMIN_PASSWORD} \
   -H "Content-Type:text/plain" \
   -XPOST http://localhost:8086/query?q=${QUERY}
}


CONTAINER_BACKUP_DIR=/backup/${INFLUXDB_DB}
CONTAINER_DUMP_FILE=/backup/influxdb_${INFLUXDB_DB}_data.tar.gz

# On RUNNING Pod/Container
echo "Unpack ${CONTAINER_DUMP_FILE}..."
tar -xzvf ${CONTAINER_DUMP_FILE} -C /backup

# First must delete database otherwise meta restore errors
echo "DROP DATABASE ${INFLUXDB_DB}..."
query "DROP DATABASE ${INFLUXDB_DB}"

echo "Restore ${INFLUXDB_DB} from ${CONTAINER_BACKUP_DIR} ..."
influxd restore -portable -db ${INFLUXDB_DB} -newdb ${INFLUXDB_DB} ${CONTAINER_BACKUP_DIR}

echo "Restore permissions for users ${INFLUXDB_READ_USER} and ${INFLUXDB_WRITE_USER} ..."
query "GRANT READ ON ${INFLUXDB_DB} TO ${INFLUXDB_READ_USER}"
query "GRANT ALL ON ${INFLUXDB_DB} TO ${INFLUXDB_WRITE_USER}"

echo "Removing unpacked backup in ${CONTAINER_BACKUP_DIR} ..."
rm -rf ${CONTAINER_BACKUP_DIR}
