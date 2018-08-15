# Kubernetes

Onderstaande is een mogelijk security issue. Dit moeten we tzt oplossen.

```
$ kubectl create -f ./kube-system/rbac.yml
```

## Ingress-Nginx

Proxy server

```
$ kubectl apply -f ./ingress-nginx/namespace.yml
$ kubectl apply -f ./ingress-nginx/default-backend.yml
$ kubectl apply -f ./ingress-nginx/rbac.yml
$ kubectl apply -f ./ingress-nginx/deployment.yml
$ kubectl apply -f ./ingress-nginx/service.yml
```

## Cert-Manager

Let's encrypt cert manager. Set your email address in the files `letsencrypt-staging.clusterissuer.yml` and `letsencrypt-prod.clusterissuer.yml`.

```
$ kubectl create -f ./cert-manager/namespace.yml
$ kubectl create -f ./cert-manager/rbac.yml
$ kubectl create -f ./cert-manager/crd.yml
$ kubectl create -f ./cert-manager/deployment.yml
$ kubectl create -f ./cert-manager/letsencrypt-staging.clusterissuer.yml
$ kubectl create -f ./cert-manager/letsencrypt-prod.clusterissuer.yml
```

## Smart Emission

The Smart Emission stack

### Namespace

```
$ kubectl create -f ./smartemission/namespace.yml
```

### Certificate

```
$ kubectl create -f ./smartemission/certificate.yml
```

### Secrets

Secrets not included in the repository.

```
$ kubectl create -f ./smartemission/secrets/geoserver.yml
$ kubectl create -f ./smartemission/secrets/postgres.yml
$ kubectl create -f ./smartemission/secrets/basic-auth.yml
$ kubectl create -f ./smartemission/secrets/sos52n.yml
$ kubectl create -f ./smartemission/secrets/data-collectors.yml
$ kubectl create -f ./smartemission/secrets/influxdb.yml
$ kubectl create -f ./smartemission/secrets/influxdb-reader.yml
$ kubectl create -f ./smartemission/secrets/influxdb-writer.yml
$ kubectl create -f ./smartemission/secrets/grafana.yml
```

### Services / Deployments

The `postgres-external.yml` service is not available in the repository. Create your own with the name `postgres`.

```
$ kubectl create -f ./smartemission/services/postgres-external/deployment.yml
$ kubectl create -f ./smartemission/services/postgres-external/service.yml

$ kubectl create -f ./smartemission/services/geoserver/deployment.yml
$ kubectl create -f ./smartemission/services/geoserver/service.yml
$ kubectl create -f ./smartemission/services/geoserver/ingress.yml

$ kubectl create -f ./smartemission/services/sos52n/deployment.yml
$ kubectl create -f ./smartemission/services/sos52n/service.yml
$ kubectl create -f ./smartemission/services/sos52n/ingress.yml

$ kubectl create -f ./smartemission/services/sosemu/deployment.yml
$ kubectl create -f ./smartemission/services/sosemu/service.yml
$ kubectl create -f ./smartemission/services/sosemu/ingress.yml

$ kubectl create -f ./smartemission/services/influxdb/service.yml
$ kubectl create -f ./smartemission/services/influxdb/statefulset.yml
$ kubectl create -f ./smartemission/services/influxdb/ingress.yml

$ kubectl create -f ./smartemission/services/smartapp/deployment.yml
$ kubectl create -f ./smartemission/services/smartapp/service.yml
$ kubectl create -f ./smartemission/services/smartapp/ingress.yml

$ kubectl create -f ./smartemission/services/waalkade/deployment.yml
$ kubectl create -f ./smartemission/services/waalkade/service.yml
$ kubectl create -f ./smartemission/services/waalkade/ingress.yml

$ kubectl create -f ./smartemission/services/home/deployment.yml
$ kubectl create -f ./smartemission/services/home/service.yml
$ kubectl create -f ./smartemission/services/home/ingress.yml

$ kubectl create -f ./smartemission/services/heron/deployment.yml
$ kubectl create -f ./smartemission/services/heron/service.yml
$ kubectl create -f ./smartemission/services/heron/ingress.yml

$ kubectl create -f ./smartemission/services/mosquitto/deployment.yml
$ kubectl create -f ./smartemission/services/mosquitto/service.yml

$ kubectl create -f ./smartemission/services/gost/deployment.yml
$ kubectl create -f ./smartemission/services/gost/service.yml
$ kubectl create -f ./smartemission/services/gost/ingress.yml

$ kubectl create -f ./smartemission/services/admin/deployment.yml
$ kubectl create -f ./smartemission/services/admin/service.yml
$ kubectl create -f ./smartemission/services/admin/ingress.yml

$ kubectl create -f ./smartemission/services/grafana/deployment.yml
$ kubectl create -f ./smartemission/services/grafana/service.yml
$ kubectl create -f ./smartemission/services/grafana/ingress.yml

$ kubectl create -f ./smartemission/services/postgres-pool/deployment.yml
$ kubectl create -f ./smartemission/services/postgres-pool/service.yml
```

### CronJobs

```
$ kubectl create -f ./smartemission/cronjobs/etl-last.yml
$ kubectl create -f ./smartemission/cronjobs/etl-whale.yml
$ kubectl create -f ./smartemission/cronjobs/etl-refiner.yml
$ kubectl create -f ./smartemission/cronjobs/etl-sta-publisher.yml
$ kubectl create -f ./smartemission/cronjobs/etl-rivm-harvester.yml
$ kubectl create -f ./smartemission/cronjobs/etl-influxdb-harvester.yml
$ kubectl create -f ./smartemission/cronjobs/etl-sos-publisher.yml
$ kubectl create -f ./smartemission/cronjobs/etl-extractor.yml
```

## Monitoring

### Namespace

```
$ kubectl create -f ./monitoring/namespace.yml
```

### Secrets

Secrets not included in the repository.

```
$ kubectl create -f ./monitoring/secrets/basic-auth.yml
$ kubectl create -f ./monitoring/secrets/pgadmin.yml
```

### Services / Deployments

```
$ kubectl create -f ./monitoring/services/postgres-external.yml

$ kubectl create -f ./monitoring/services/elasticsearch/rbac.yml
$ kubectl create -f ./monitoring/services/elasticsearch/configmap.yml
$ kubectl create -f ./monitoring/services/elasticsearch/service.yml
$ kubectl create -f ./monitoring/services/elasticsearch/stateful-set.yml

$ kubectl create -f ./monitoring/services/fluentd/rbac.yml
$ kubectl create -f ./monitoring/services/fluentd/config-map.yml
$ kubectl create -f ./monitoring/services/fluentd/daemon-set.yml

$ kubectl create -f ./monitoring/services/kibana/deployment.yml
$ kubectl create -f ./monitoring/services/kibana/service.yml
$ kubectl create -f ./monitoring/services/kibana/ingress.yml

$ kubectl create -f ./monitoring/services/phppgadmin/deployment.yml
$ kubectl create -f ./monitoring/services/phppgadmin/service.yml
$ kubectl create -f ./monitoring/services/phppgadmin/ingress.yml

$ kubectl create -f ./monitoring/services/prometheus/rbac.yml
$ kubectl create -f ./monitoring/services/prometheus/configmap.yml
$ kubectl create -f ./monitoring/services/prometheus/deployment.yml
$ kubectl create -f ./monitoring/services/prometheus/service.yml
$ kubectl create -f ./monitoring/services/prometheus/ingress.yml

$ kubectl create -f ./monitoring/services/grafana/configmap.yml
$ kubectl create -f ./monitoring/services/grafana/deployment.yml
$ kubectl create -f ./monitoring/services/grafana/service.yml
```

### CronJobs

```
$ kubectl create -f ./monitoring/cronjobs/curator/config-map.yml
$ kubectl create -f ./monitoring/cronjobs/curator/cronjob.yml
```

## Kube-System

### Secrets

Secrets not included in the repository.

```
$ kubectl create -f ./kube-system/secrets/basic-auth.yml
```

### Services / Deployments

```
$ kubectl create -f ./kube-system/services/kubernetes-dashboard/ingress.yml
$ kubectl create -f ./kube-system/services/kubernetes-dashboard/rbac.yml
```

## Collectors

### Namespace

```
$ kubectl create -f ./collectors/namespace.yml
```

### Secrets

Secrets not included in the repository.

```
$ kubectl create -f ./collectors/secrets/dc-airsenseur-admin.yml
$ kubectl create -f ./collectors/secrets/dc-airsenseur-reader.yml
$ kubectl create -f ./collectors/secrets/dc-airsenseur-writer.yml
$ kubectl create -f ./collectors/secrets/dc-grafana.yml
```

### Services / Deployments

```
$ kubectl create -f ./collectors/services/dc-airsenseur/statefulset.yml
$ kubectl create -f ./collectors/services/dc-airsenseur/service.yml

$ kubectl create -f ./collectors/services/dc-grafana/deployment.yml
$ kubectl create -f ./collectors/services/dc-grafana/service.yml
$ kubectl create -f ./collectors/services/dc-grafana/ingress.yml
```