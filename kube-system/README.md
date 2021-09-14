# `kube-system` Namespace

## authelia

This is probably overly-complicated for what I actually need and I will probably simplify it in the future. Authelia provides SSO capabilities for the cluster and is integrated with nginx-ingress.

* [authelia/authelia-helm-values.template](authelia/authelia-helm-values.template) - Template used to create helm value secrets for authelia via [seal-secrets.sh](/setup/seal-secrets.sh)
* [authelia/authelia-helm-values.yaml](authelia/authelia-helm-values.yaml) - Encrypted secrets for Authelia
* [authelia/authelia-postgres-helm-values.template](authelia/authelia-postgres-helm-values.template) - Template used to create helm value secrets for postgres via [seal-secrets.sh](/setup/seal-secrets.sh)
* [authelia/authelia-postgres-helm-values.yaml](authelia/authelia-postgres-helm-values.yaml) - Encrypted secrets for Postgres
* [authelia/authelia-redis-password.template](authelia/authelia-redis-password.template) - Template used to create password secrets for redis via [seal-secrets.sh](/setup/seal-secrets.sh)
* [authelia/authelia-redis-password.yaml](authelia/authelia-redis-password.yaml) - Encrypted password secret for Redis
* [authelia/authelia.yaml](authelia/authelia.yaml) - Authelia SSO Server Helm Chart deployment
* [authelia/postgres.yaml](authelia/postgres.yaml) - Postgres deployment for use by Authelia for registering user second-factor
* [authelia/redis.yaml](authelia/redis.yaml) - Redis deployment for use by Authelia for sessions

## dynamic-dns

A custom docker image and cron job that uses the AWS cli to udpate a dns reocord pointing to the cluster's external IP address.

* [dynamic-dns/cronjob.yaml](dynamic-dns/cronjob.yaml) - Cron Job which schedules the DNS update
* [dynamic-dns/route53-env.template](dynamic-dns/route53-env.template) - Template used to create environment variable secrets for the update script via [seal-secrets.sh](/setup/seal-secrets.sh)
* [dynamic-dns/route53-env.yaml](dynamic-dns/route53-env.yaml) - Environment secrets for update script inside docker image

## kured

[Kured](https://github.com/weaveworks/kured) is a Kubernetes daemonset that performs safe automatic node reboots when the need to do so is indicated by the package management system of the underlying OS.

* [kured/kured-helm-values.template](kured/kured-helm-values.template) - Template used to create helm value secrets for kured via [seal-secrets.sh](/setup/seal-secrets.sh)
* [kured/kured-helm-values.yaml](kured/kured-helm-values.yaml) - Encrypted secrets for kured
* [kured/kured.yaml](kured/kured.yaml) - HelmRelease for kured

## metallb

[MetalLB](https://metallb.universe.tf/) is an on-cluster LoadBalancer in the Layer 2 configuration to allow for "external" IPs to be assigned. Primarily used with nginx below.

* [metallb/metallb.yaml](metallb/metallb.yaml) - HelmRelease for metallb, including values configuration.

## nfs-pv

Persistent Volume configuration for shared NFS storage.

* [nfs-pv/media-pv.yaml](nfs-pv/media-pv.yaml) - Bulk media storage backed by a TrueNAS NFS share
* [nfs-pv/minio-pv.yaml](nfs-pv/minio-pv.yaml) - Storage for Minio S3 Compatible storage backed by TrueNAS NFS share

## nginx

[Nginx ingress controller](https://kubernetes.github.io/ingress-nginx/) for the cluster, works with cert-manager to secure and route traffic to specific pods/applications.

* [nginx/nginx-internal.yaml](nginx/nginx-internal.yaml) - HelmRelease for nginx-ingress serving internal traffic, including custom 404 pages from billimek/custom-error-pages
* [nginx/nginx-external.yaml](nginx/nginx-external.yaml) - HelmRelease for nginx-ingress serving external traffic, including custom 404 pages from billimek/custom-error-pages

## openldap

Trying out creating an LDAP provider for the cluster to do authentication at the nginx-ingress level.

* [openldap/openldap.yaml](openldap/openldap.yaml) - Deployment and Service to expose an OpenLDAP instance based on bitnami containers
* [openldap/openldap-secrets.template](openldap/openldap-secrets.template) - Template used to create the openldap username and password secrets via [seal-secrets.sh](/setup/seal-secrets.sh)
* [openldap/openldap-secrets.yaml](openldap/openldap-secrets.yaml) - My encrypted open ldap secrets

## registrycreds

Provide authentication using [alexellis' registry-creds](https://github.com/alexellis/registry-creds) across the cluster for Docker Hub and raise the pull limit a bit so that we are less likely to hit it.

* [registry-creds/registry-creds.yaml](registry-creds/registry-creds.yaml) - Deployment for registry-creds.
* [registry-creds/registry-creds-crd.yaml](registry-creds/registry-creds-crd.yaml) - CRD, Roles, ClusterRoles, RoleBinding, and ClusterRoleBinding for registry-creds.
* [registry-creds/dockerhub.yaml](registry-creds/dockerhub.yaml) - The ClusterPullSecret which binds the docker-registry secrets to teh registry-creds deployment to be used by kubernetes
* [registry-creds/registry-creds-secret.template](registry-creds/registry-creds-secret.template) - Template used to create the docker-registry type secret via [seal-secrets.sh](/setup/seal-secrets.sh)
* [registry-creds/registry-creds-secret.yaml](registry-creds/registry-creds-secret.yaml) - My encrypted open dockerhub secret
