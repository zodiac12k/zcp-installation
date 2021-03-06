#!/bin/bash

# variables
TARGET_NAMESPACE=zcp-system
HARBOR_INGRESS_HOSTS=iks-dev-registry.cloudzcp.io
HARBOR_INGRESS_CONTROLLER=private-cr0ce3d46f6765441ca772dcb67bbf2a40-alb1
HARBOR_ADMIN_PASSWORD=
HARBOR_S3_ACCESSKEY=
HARBOR_S3_SECRETKEY=
HARBOR_S3_BUCKET=
HARBOR_BACKUP_S3_ACCESSKEY=
HARBOR_BACKUP_S3_SECRETKEY=
HARBOR_BACKUP_S3_BUCKET=

# extract secret
HARBOR_TLS_CRT=$(kubectl get secret cloudzcp-io-cert --namespace ${TARGET_NAMESPACE} -o jsonpath="{.data.tls\.crt}" | base64 --decode)
HARBOR_TLS_KEY=$(kubectl get secret cloudzcp-io-cert --namespace ${TARGET_NAMESPACE} -o jsonpath="{.data.tls\.key}" | base64 --decode)
ZCP_ADMIN_SECRET=$(kubectl get sa zcp-system-admin --namespace ${TARGET_NAMESPACE} -o jsonpath="{.secrets[0].name}")

# install helm chart
helm repo add zcp https://raw.githubusercontent.com/cnpst/charts/master/docs

# Install harbor
# Chart revision for harbor : https://github.com/cnpst/zcp-registry
# Chart revision for postgresql : https://github.com/helm/charts/tree/f2938a46e3ae8e2512ede1142465004094c3c333/stable/postgresql
# Chart revision for redis : https://github.com/helm/charts/tree/f9918a9b38231c18ab47a8a6119cf430106aa87a/stable/redis
helm install zcp/zcp-registry --version 1.0.0 \
--name zcp-registry \
-f values-iks.yaml \
--namespace ${TARGET_NAMESPACE} \
--set tlsCrt="${HARBOR_TLS_CRT}" \
--set tlsKey="${HARBOR_TLS_KEY}" \
--set externalDomain=${HARBOR_INGRESS_HOSTS} \
--set ingress.annotations."ingress\.bluemix\.net/ALB-ID"=${HARBOR_INGRESS_CONTROLLER} \
--set adminserver.adminPassword=${HARBOR_ADMIN_PASSWORD} \
--set adminserver.volumes.config.storageClass=ibmc-file-retain-silver \
--set adminserver.volumes.config.size=20Gi \
--set mysql.volumes.data.storageClass=ibmc-block-retain-silver \
--set mysql.volumes.data.size=20Gi \
--set postgresql.persistence.storageClass=ibmc-block-retain-silver \
--set postgresql.persistence.size=20Gi \
--set registry.objectStorage.s3.accesskey=${HARBOR_S3_ACCESSKEY} \
--set registry.objectStorage.s3.secretkey=${HARBOR_S3_SECRETKEY} \
--set registry.objectStorage.s3.bucket=${HARBOR_S3_BUCKET} \
--set backup.serviceAccountSecretName=${ZCP_ADMIN_SECRET} \
--set backup.objectStorage.s3.accesskey=${HARBOR_BACKUP_S3_ACCESSKEY} \
--set backup.objectStorage.s3.secretkey=${HARBOR_BACKUP_S3_SECRETKEY} \
--set backup.objectStorage.s3.bucket=${HARBOR_BACKUP_S3_BUCKET}
