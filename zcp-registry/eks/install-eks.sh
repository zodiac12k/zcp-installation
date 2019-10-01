#!/bin/bash

# variables
namespace=zcp-system

# create pvc
kubectl create -f harbor-pvc-eks.yaml --namespace "$namespace"
kubectl create -f psql-pvc-eks.yaml --namespace "$namespace"

# install helm chart
helm install harbor/harbor --name zcp-registry \
  --set harborImageTag="&harbor_image_tag v1.7.5" \
  --namespace zcp-system --version 1.0.1 \
  -f values-eks.yaml

# install helm chart with persistvolume  
# helm install harbor/harbor --name zcp-registry \
#   --set harborImageTag="&harbor_image_tag v1.7.5" \
#   --namespace zcp-system --version 1.0.1 \
#   -f values-eks-persist-true.yaml

# kubectl delete sts zcp-registry-harbor-database
# kubectl apply -f zcp-registry-harbor-database-liveness.yaml 

kubectl get pod -n zcp-system -w | grep harbor
