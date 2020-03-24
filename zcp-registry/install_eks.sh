#!/bin/bash

# variables
TARGET_NAMESPACE=zcp-system
HARBOR_INGRESS_HOSTS=eks-dev-registry.cloudzcp.io
HARBOR_INGRESS_CONTROLLER=nginx
HARBOR_EXTERNAL_URL=https://eks-dev-registry.cloudzcp.io
HARBOR_ADMIN_PASSWORD=
HARBOR_S3_ACCESSKEY=
HARBOR_S3_SECRETKEY=
HARBOR_S3_BUCKET=

# Install harbor
# Chart revision for harbor : https://github.com/goharbor/harbor-helm/tree/v1.0.1
helm repo add harbor https://helm.goharbor.io

helm install harbor/harbor --version 1.0.1 \
--name zcp-registry \
-f values-eks.yaml \
--namespace ${TARGET_NAMESPACE} \
--set expose.ingress.hosts.core=${HARBOR_INGRESS_HOSTS} \
--set expose.ingress.annotations."kubernetes\.io/ingress\.class"=${HARBOR_INGRESS_CONTROLLER} \
--set externalURL=${HARBOR_EXTERNAL_URL} \
--set harborAdminPassword=${HARBOR_ADMIN_PASSWORD} \
--set persistence.persistentVolumeClaim.jobservice.storageClass=efs-zcp \
--set persistence.persistentVolumeClaim.jobservice.size=20Gi \
--set persistence.persistentVolumeClaim.database.storageClass=ebs-gp2 \
--set persistence.persistentVolumeClaim.database.size=5Gi \
--set persistence.persistentVolumeClaim.redis.storageClass=ebs-gp2 \
--set persistence.persistentVolumeClaim.redis.size=5Gi \
--set persistence.imageChartStorage.s3.accesskey=${HARBOR_S3_ACCESSKEY} \
--set persistence.imageChartStorage.s3.secretkey=${HARBOR_S3_SECRETKEY} \
--set persistence.imageChartStorage.s3.bucket=${HARBOR_S3_BUCKET} \
