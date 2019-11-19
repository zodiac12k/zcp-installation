. env.properties

kubectl create secret generic realm-secret -n ${TARGET_NAMESPACE} --from-file=realm-zcp-export.json

# Install keycloak and postgresql for keycloak
# Chart revision for keycloak : https://github.com/helm/charts/tree/8f5c3426d9597a902d57bea378dc628ea2b91c20/stable/keycloak
# Chart revision for postgresql : https://github.com/helm/charts/tree/93ccc2350550ff5d95f13a5c25dc54babc44c048/stable/postgresql
helm install stable/keycloak --version 2.0.0 \
--name zcp-oidc \
-f values-eks.yaml \
--namespace ${TARGET„_NAMESPACE} \
--set keycloak.username=${KEYCLOAK_ADMIN_ID} \
--set keycloak.password=${KEYCLOAK_ADMIN_PWD} \
--set keycloak.ingress.hosts[0]=${KEYCLOAK_INGRESS_HOSTS} \
--set keycloak.ingress.annotations."kubernetes.io\/ingress.class"=${KEYCLOAK_INGRESS_CONTROLLER} \
--set keycloak.ingress.tls[0].hosts[0]=${KEYCLOAK_INGRESS_HOSTS} \
--set keycloak.ingress.tls[0].secretName=${DOMAIN_SECRET_NAME} \
--set postgresql.postgresPassword=${KEYCLOAK_DB_PWD} \
--set postgresql.persistence.enabled=true \
--set postgresql.persistence.storageClass=zcp-efs \
--set postgresql.persistence.size=20Gi
#--set keycloak.resources.limits.cpu=${KEYCLOAK_LIMIT_CPU} \
#--set keycloak.resources.limits.memory=${KEYCLOAK_LIMIT_MEM} \
#--set keycloak.resources.requests.cpu=${KEYCLOAK_REQUEST_CPU} \
#--set keycloak.resources.requests.memory=${KEYCLOAK_REQUEST_MEM} \
#--set postgresql.postgresUser=${KEYCLOAK_DB_USER} \
#--set postgresql.postgresDatabase=${KEYCLOAK_DB_NAME} \
#--set postgresql.persistence.enabled=true \
#--set postgresql.metrics.enabled=true \
#--set postgresql.persistence.existingClaim=${KEYCLOAK_DB_PVC_NAME}