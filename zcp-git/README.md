# The zcp-git Installation Guide

## ZCP-git Component 

| Component        | Version           | Image  | etc |
| ------------- |-------------|-----|----|
|Gitea| 1.4 |gitea/gitea:1.4
|Postgres| 9.6.2 |postgres:9.6.2

## Prerequisite

1. `cloudzcp-io-cert` cloudzcp.io 인증서 secret
2. helm client v2.9.1 이상

## Install with helm

### for IKS

#### env.properties 파일 수정
env.properties 파일을 편집기로 열어 아래 항목을 프로젝트에 맞게 수정한다.

```
$ vi env.properties 
```

```
# target namespace installed
TARGET_NAMESPACE=zcp-system

# gitea domain certificate secret name
DOMAIN_SECRET_NAME=cloudzcp-io-cert

# gitea domain host
GITEA_INGRESS_HOSTS=iks-dev-git.cloudzcp.io
GITEA_INGRESS_TLS_HOSTS=iks-dev-git.cloudzcp.io
GITEA_INGRESS_CONTROLLER=private-cr0ce3d46f6765441ca772dcb67bbf2a40-alb1
```

#### Helm install 수행

```
$ ./install_iks.sh
```

### for EKS

#### env.properties 파일 수정
env.properties 파일을 편집기로 열어 아래 항목을 프로젝트에 맞게 수정한다.

```
$ vi env.properties 
```

```
# target namespace installed
TARGET_NAMESPACE=zcp-system

# gitea domain certificate secret name
DOMAIN_SECRET_NAME=cloudzcp-io-cert

# gitea domain host
GITEA_INGRESS_HOSTS=eks-dev-git.cloudzcp.io
GITEA_INGRESS_TLS_HOSTS=eks-dev-git.cloudzcp.io
GITEA_INGRESS_CONTROLLER=nginx
```

#### Helm install 수행

```
$ ./install_eks.sh
```