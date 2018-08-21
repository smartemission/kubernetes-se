#!/bin/bash
#
# Dump InfluxDB and copy dump file to specified dumpfile.
# Author: Just van den Broecke
# Usage: backup.sh <dump file .tar.gz>
# Example: backup.sh influxdb-dc1_airsenseur_181123.tar.gz
#

SCRIPT_DIR=${0%/*}

pushd ${SCRIPT_DIR}
	if [ ! -f influxdb.env ]
	then
	    echo "Bestand influxdb.env niet gevonden."
	    exit 1
	fi
    source influxdb.env
popd

# Need dump file tar.gz as arg
DUMP_FILE="$1"
if [ "${DUMP_FILE}x" = "x" ];
then
    echo "Error: no dump file specified"
    exit -1
fi

# Copy and execute script on RUNNING Pod/Container
CMD="backup-cmd.sh"
kubectl cp ${CMD} ${NS}/${CONTAINER_NAME}:/${CMD}
kubectl -n ${NS} exec ${CONTAINER_NAME} -- chmod +x /${CMD}
kubectl -n ${NS} exec ${CONTAINER_NAME} -- /${CMD}
kubectl cp ${NS}/${CONTAINER_NAME}:${CONTAINER_DUMP_FILE} ${DUMP_FILE}

# kubectl -n ${NS exec ${CONTAINER_NAME} -- rm -rf ${CONTAINER_BACKUP_DIR} ${CONTAINER_DUMP_FILE}
