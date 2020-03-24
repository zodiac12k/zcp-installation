# The zcp-jenkins Installation Guide

## ZCP-jenkins Component 

| Component        | Version           | Image  | etc |
| ------------- |-------------|-----|----|
|Jenkins| 1.121.3 |jenkins/jenkins:1.121.3


## Prerequisite

1. `zcp-system-admin` Service Account
2. `cloudzcp-io-cert` cloudzcp.io 인증서 secret
3. helm client v2.9.1 이상

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

# jenkins domain certificate secret name
DOMAIN_SECRET_NAME=cloudzcp-io-cert

# jenkins user account
JENKINS_ADMIN_ID=admin
JENKINS_ADMIN_PWD=***

# jenkins domain host
JENKINS_INGRESS_HOSTS=iks-dev-devops.cloudzcp.io
JENKINS_INGRESS_TLS_HOSTS=iks-dev-devops.cloudzcp.io
JENKINS_INGRESS_CONTROLLER=private-cr0ce3d46f6765441ca772dcb67bbf2a40-alb1
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

# jenkins domain certificate secret name
DOMAIN_SECRET_NAME=cloudzcp-io-cert

# jenkins user account
JENKINS_ADMIN_ID=admin
JENKINS_ADMIN_PWD=***

# jenkins domain host
JENKINS_INGRESS_HOSTS=eks-dev-devops.cloudzcp.io
JENKINS_INGRESS_TLS_HOSTS=eks-dev-devops.cloudzcp.io
JENKINS_INGRESS_CONTROLLER=nginx
```

#### Helm install 수행

```
$ ./install_eks.sh
```

### Jenkins Plugins 복사
검증이 완료 된 버전의 Jenkins plugin 을 사용하기 위해 values 파일의 InstallPlugins 를 사용하지 않고 Plugin 을 직접 Jenkins pod 에 복사한다.

Jenkins pod 에 완전히 기동되었는지 확인한다. Running 상태여야 파일 복사가 가능하다.
```
$ kubectl get po -l app=zcp-jenkins -n zcp-system
NAME                           READY     STATUS    RESTARTS   AGE
zcp-jenkins-86c545fc87-n84vl   1/1       Running   0          1d
```

git 에서 plugin 파일을 받는다. 용량이 커서 별도의 repository 로 관리하고 있다.
```
$ cd ../..
$ git clone https://github.com/cnpst/zcp-jenkins-plugins.git
```

plugin을 jenkins pod 으로 복사한다.
```
$ cd zcp-jenkins-plugins
$ kubectl cp plugins  `(kubectl get po -l app=zcp-jenkins -o jsonpath='{.items[0].metadata.name}' -n zcp-system)`:var/jenkins_home -n zcp-system
```

Jenkins 를 재기동한다.
```
$ kubectl scale deploy zcp-jenkins --replicas=0 -n zcp-system
$ kubectl scale deploy zcp-jenkins --replicas=1 -n zcp-system
```
