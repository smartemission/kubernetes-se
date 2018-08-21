# Data Collector 1

This Data Collector runs InfluxDB to assemble raw data from various
sensors. Most significantly AirSensEUR.

## Databases

Mainly `airsenseur`.

## Backup and Restore

Needs `kubectl` with K8s Cluster access. See also:
https://docs.influxdata.com/influxdb/v1.6/administration/backup_and_restore

Backup: backs up single database, for now hardcoded as `airsenseur`.
TODO: if multiple databases need to be supported: extend scripts.

```
$ ./backup.sh <backup_file.tar.gz>
```

Creates `.tar.gz` file containing InfluxDB data in `portable` format with top dir having database name.


```
$ ./restore.sh <backup_file.tar.gz>
```

Restores from `.tar.gz` file containing InfluxDB data in 
`portable` format with top dir having database name.

## Testing

tests if database is working, queries last record added within last hour.

```
$ ./test.sh
```
