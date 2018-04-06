# Kubernetes

## Ingress-Nginx

Proxy server

```
$ kubectl apply -f ./ingress-nginx/namespace.yml
$ kubectl apply -f ./ingress-nginx/default-backend.yml
$ kubectl apply -f ./ingress-nginx/config-map.yml
$ kubectl apply -f ./ingress-nginx/tcp-services-configmap.yml
$ kubectl apply -f ./ingress-nginx/udp-services-configmap.yml
$ kubectl apply -f ./ingress-nginx/without-rbac.yml
$ kubectl patch deployment -n ingress-nginx nginx-ingress-controller --type='json' --patch=$(cat ./ingress-nginx/publish-service-patch.yml)
$ kubectl apply -f ./ingress-nginx/service.yml
$ kubectl apply -f ./ingress-nginx/patch-service-without-rbac.yml
```

## Cert-Manager

Let's encrypt cert manager. Set your email address in the files `letsencrypt-staging.clusterissuer.yml` and `letsencrypt-prod.clusterissuer.yml`.

```
$ kubectl create -f ./cert-manager/namespace.yml
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
$ kubectl create -f ./smartemission/secrets/etl-last.yml
```

### Services / Deployments

The `postgres-external.yml` service is not available in the repository. Create your own with the name `postgres`.

```
$ kubectl create -f ./smartemission/services/postgres-external/deployment.yml
$ kubectl create -f ./smartemission/services/postgres-external/service.yml

$ kubectl create -f ./smartemission/services/geoserver/deployment.yml
$ kubectl create -f ./smartemission/services/geoserver/service.yml

$ kubectl create -f ./smartemission/services/basic-auth-geoserver/deployment.yml
$ kubectl create -f ./smartemission/services/basic-auth-geoserver/service.yml

$ kubectl create -f ./smartemission/services/sos52n/deployment.yml
$ kubectl create -f ./smartemission/services/sos52n/service.yml

$ kubectl create -f ./smartemission/services/sosemu/deployment.yml
$ kubectl create -f ./smartemission/services/sosemu/service.yml

$ kubectl create -f ./smartemission/services/influxdb/service.yml
$ kubectl create -f ./smartemission/services/influxdb/statefulset.yml

$ kubectl create -f ./smartemission/ingress.yml
```

### CronJobs

```
$ kubectl create -f ./smartemission/cronjobs/etl-last.yml
```
