# zcp-common installation guide

## tls secret 생성
```
$ cd keycloak
```

Ingress 에 적용할 TLS Secret 을 생성 한다.

TLS Secret 이 이미 생성되어 있는 경우 생략 할 수 있다.

tls-secret.yaml 의 내용을 실제 인증서의 값으로 수정 한다.

metadata.namespace 의 값이 env.properties 의 TARGET_NAMESPACE 와 동일해야 한다.

metadata.name 이 env.properties 의 DOMAIN_SECRET_NAME 과 동일해야 한다.

```
$ vi tls-secret.yaml
```

```
apiVersion: v1
data:
  tls.crt: xxxx
  tls.key: xxxx
kind: Secret
metadata:
  name: cloudzcp-io-cert
  namespace: zcp-system
type: kubernetes.io/tls
```

```
$ kubectl create -f tls-secret.yaml
```

다음 명령어로 Secret 이 생성된 것을 확인한다.

```
$ kubectl get secret -n zcp-system
```