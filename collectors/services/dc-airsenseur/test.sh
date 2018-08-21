#!/bin/bash
# Perform tests within container.
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

# Copy and execute script on RUNNING Pod/Container
CMD="test-cmd.sh"
kubectl cp ${CMD} ${NS}/${CONTAINER_NAME}:/${CMD}
kubectl -n ${NS} exec ${CONTAINER_NAME} -- chmod +x /${CMD}
kubectl -n ${NS} exec ${CONTAINER_NAME} -- /${CMD}
kubectl -n ${NS} exec ${CONTAINER_NAME} -- rm -f /${CMD}
