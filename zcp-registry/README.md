# The zcp-registry Installation Guide

zcp-registry 은 Harbor 기반의 Private Docker Registry 이다.

zcp-registry 를 설치하기 이전에 https용 공인 인증서가 필요하다.

## Clone this project into the desktop
```
$ git clone https://github.com/cnpst/zcp-installation.git
```

## for IKS

### ENV 수정

```
$ vi install_iks.sh
```

```
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
```

### Helm install 수행

```
$ ./install_iks.sh
```
