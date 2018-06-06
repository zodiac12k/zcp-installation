#!/bin/bash

echo -e "Please select number you want install."
echo "1. All"
echo "2. Registry"
echo "3. Catalog"

echo -e "Insert a number: \c "
read number

if [ $number == 2  -o  $number == 1 ]
then
  echo "Start ZCP Registry installation..."

  kubectl create -f zcp-registry/adminserver-pvc.yaml \
  --namespace "$namespace"
  kubectl create -f zcp-registry/mysql-pvc.yaml \
  --namespace "$namespace"
  kubectl create -f zcp-registry/psql-pvc.yaml \
  --namespace "$namespace"

  registry_crt=$(kubectl get secret "$tls_secret" \
  --namespace "$namespace" \
  -o jsonpath="{.data.tls\.crt}" | base64 --decode)

  registry_key=$(kubectl get secret "$tls_secret" \
  --namespace "$namespace" \
  -o jsonpath="{.data.tls\.key}" | base64 --decode)

  helm install --name zcp-registry \
    --namespace "$namespace" \
    -f zcp-registry/values.yaml \
    --set externalDomain="registry.${domain}" \
    --set tlsCrt="$registry_crt" \
    --set tlsKey="$registry_key" \
    --set adminserver.adminPassword="${registry_admin_pwd}" \
    --set adminserver.emailPwd="${smtp_pwd}" \
    --set registry.objectStorage.s3.accesskey="${s3_accesskey}" \
    --set registry.objectStorage.s3.secretkey="${s3_secretkey}" \
    zcp/zcp-registry

  echo "End ZCP Registry installation."
fi

if [ $number == 3  -o  $number == 1 ]
then
  echo "Start ZCP Catalog installation..."

  kubectl create -f zcp-catalog/zcp-catalog-mongodb-pvc.yaml \
  --namespace "$namespace"

  helm install --name zcp-catalog \
    --namespace "$namespace" \
    -f zcp-catalog/values-zcp-catalog.yaml \
    zcp/zcp-catalog

  helm install --name zcp-sso-for-catalog \
    --namespace "$namespace" \
    -f zcp-catalog/values-zcp-sso.yaml \
    --set ingress.hosts[0]="catalog.${domain}" \
    --set ingress.tls[0].secretName="${tls_secret}" \
    --set ingress.tls[0].hosts[0]="catalog.${domain}" \
    --set configmap.realmPublicKey="${realm_publicKey}" \
    --set configmap.authServerUrl="${auth_url}" \
    --set configmap.secret="${catalog_client_secret}" \
    zcp/zcp-sso

  echo "End ZCP Catalog installation."
fi
