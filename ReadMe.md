# Kubernetes

## Ingress-Nginx

Proxy server

```
$ kubectl apply -f ./kubernetes/ingress-nginx/namespace.yml
$ kubectl apply -f ./kubernetes/ingress-nginx/default-backend.yml
$ kubectl apply -f ./kubernetes/ingress-nginx/config-map.yml
$ kubectl apply -f ./kubernetes/ingress-nginx/tcp-services-configmap.yml
$ kubectl apply -f ./kubernetes/ingress-nginx/udp-services-configmap.yml
$ kubectl apply -f ./kubernetes/ingress-nginx/without-rbac.yml
$ kubectl patch deployment -n ingress-nginx nginx-ingress-controller --type='json' --patch=$(cat ./kubernetes/ingress-nginx/publish-service-patch.yml)
$ kubectl apply -f ./kubernetes/ingress-nginx/service.yml
$ kubectl apply -f ./kubernetes/ingress-nginx/patch-service-without-rbac.yml
```

## Cert-Manager

Let's encrypt cert manager. Set your email address in the files `letsencrypt-staging.clusterissuer.yml` and `letsencrypt-prod.clusterissuer.yml`.

```
$ kubectl create -f ./kubernetes/cert-manager/namespace.yml
$ kubectl create -f ./kubernetes/cert-manager/crd.yml
$ kubectl create -f ./kubernetes/cert-manager/deployment.yml
$ kubectl create -f ./kubernetes/cert-manager/letsencrypt-staging.clusterissuer.yml
$ kubectl create -f ./kubernetes/cert-manager/letsencrypt-prod.clusterissuer.yml
```

## Smart Emission

The Smart Emission stack

### Namespace

```
$ kubectl create -f ./kubernetes/smartemission/namespace.yml
```

### Certificate

```
$ kubectl create -f ./kubernetes/smartemission/certificate.yml
```

### Secrets

Secrets not included in the repository.

```
$ kubectl create -f ./kubernetes/smartemission/secrets/geoserver.yml
$ kubectl create -f ./kubernetes/smartemission/secrets/postgres.yml
$ kubectl create -f ./kubernetes/smartemission/secrets/basic-auth.yml
$ kubectl create -f ./kubernetes/smartemission/secrets/sos52n.yml
```

### Services / Deployments

The `postgres-external.yml` service is not available in the repository. Create your own with the name `postgres`.

```
$ kubectl create -f ./kubernetes/smartemission/services/postgres-external.yml
$ kubectl create -f ./kubernetes/smartemission/services/geoserver.yml
$ kubectl create -f ./kubernetes/smartemission/services/basic-auth-geoserver.yml
$ kubectl create -f ./kubernetes/smartemission/services/sos52n.yml
$ kubectl create -f ./kubernetes/smartemission/ingress.yml
```
