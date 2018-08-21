#!/bin/bash
#
# Deploy all Cronjobs specified in this dir, e.g. after Stetl upgrade or deployment settings changes.
# First deletes job and then creates again.
# TODO: maybe "kubectl replace -f .." is better option?
# Author: Just van den Broecke

JOB_YMLS=`ls etl-*.yml`
NS=smartemission

for JOB_YML in ${JOB_YMLS}
do
	JOB=$(echo ${JOB_YML} | cut -d'.' -f1)
	echo "Deleting cronjob ${JOB}"
	kubectl -n ${NS} delete cronjob ${JOB}
	echo "Deploying cronjob ${JOB} with ${JOB_YML}"
	kubectl create -f ${JOB_YML}
done
