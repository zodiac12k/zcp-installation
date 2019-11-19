# zcp-keycloak installation guide via Helm

## for IKS

### env.properties 파일 수정
env.properties 파일을 편집기로 열어 아래 항목을 프로젝트에 맞게 수정한다.

```
$ vi env.properties 
```

```
# target namespace installed
TARGET_NAMESPACE=zcp-system

# keycloak domain certificate secret name
DOMAIN_SECRET_NAME=cloudzcp-io-cert

# keycloak user account
KEYCLOAK_ADMIN_ID=cloudzcp-admin
KEYCLOAK_ADMIN_PWD=***

# keycloak domain host
KEYCLOAK_INGRESS_HOSTS=iks-dev-iam.cloudzcp.io
KEYCLOAK_INGRESS_TLS_HOSTS=iks-dev-iam.cloudzcp.io
KEYCLOAK_INGRESS_CONTROLLER=private-cr0ce3d46f6765441ca772dcb67bbf2a40-alb1

# keycloak db config
KEYCLOAK_DB_PWD=***
```

### Helm install 수행

```
$ ./install_iks.sh
```