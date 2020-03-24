. env.properties

# Install gitea
# Chart revision for jenkins : https://github.com/helm/charts/tree/605d3d441e6515fcbbf8a69bdc69794d90bbfd5c/stable/jenkins
helm install gitea-0.6.0.tgz --version 0.6.0 \
--name zcp-git \
-f values-iks.yaml \
--namespace ${TARGET_NAMESPACE} \
--set service.ingress.annotations."ingress\.bluemix\.net/ALB-ID"=${GITEA_INGRESS_CONTROLLER} \
--set service.ingress.hosts.host=${GITEA_INGRESS_HOSTS} \
--set service.ingress.tls[0].hosts[0]=${GITEA_INGRESS_TLS_HOSTS} \
--set service.ingress.tls[0].secretName=${DOMAIN_SECRET_NAME} \
--set persistence.storageClass=ibmc-block-retain-silver \
--set postgresql.persistence.storageClass=ibmc-block-retain-silver \
