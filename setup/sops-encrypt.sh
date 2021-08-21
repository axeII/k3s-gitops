#!/usr/bin/env bash

REPO_ROOT=$(git rev-parse --show-toplevel)
. "$REPO_ROOT"/setup/.env

seal() {
  if [ -f "${REPO_ROOT}/${1}/${2}.sops.yaml" ]; then
    echo "${2}.sops.yaml: Already exists"
  else
    echo "${2}.template: Encrypting with SOPS"
    envsubst < ${REPO_ROOT}/setup/secrets-templates/${2}.template > ${REPO_ROOT}/${1}/${2}.sops.yaml
    sops --encrypt --in-place ${REPO_ROOT}/${1}/${2}.sops.yaml
  fi
}

# cert-manager
seal 'cert-manager/cert-manager' 'route53-api-key'

# default
seal 'default/minio' 'minio-helm-values'
seal 'default/monica' 'monica-helm-values'
seal 'default/pihole' 'pihole-secret'
seal 'default/pihole' 'pihole-helm-values'

# flux-system
# seal "flux-system-extra/github-alerts/github-api-token"
# seal "flux-system-extra/discord-alerts/discord-webhook-url"

# kube-system
# seal 'kube-system/authelia/authelia-helm-values'
# seal 'kube-system/authelia/authelia-postgres-helm-values'
# seal 'kube-system/authelia/authelia-redis-password'
# seal 'kube-system/dynamic-dns/route53-env'
# seal 'kube-system/kured/kured-helm-values'
# seal 'kube-system/openldap/openldap-secrets'
# seal 'kube-system/registry-creds/registry-creds-secret'

# media
# seal 'media/plex/plex-secrets'

# monitoring
# seal "monitoring/botkube/botkube-helm-values"
# seal "monitoring/grafana/grafana-helm-values"
# seal "monitoring/grafana/grafana-ldap-toml"
# seal "monitoring/kube-prometheus-stack/kube-prometheus-stack-helm-values"
# seal "monitoring/thanos/thanos-helm-values"
