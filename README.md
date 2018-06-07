# zcp-installation

## Create tls secret

```
e.g)
kubectl create secret tls cloudzcp-io-cert -n zcp-system  --cert cloudzcp.crt --key cloudzcp.key
```

## Set environment variables

Set environment variables.

```
//common
export namespace=
export domain=
export tls_secret=
export realm_publicKey=
export auth_url=
export smtp_pwd=
export s3_accesskey=
export s3_secretkey=

//catalog
export catalog_client_secret=
export catalog_sub_domain=

//registry
export registry_admin_pwd=
export registry_sub_domain=
export registry_s3_bucket=

e.g.)
//common
export namespace=zcp-system
export domain=cloudzcp.io
export tls_secret=xxx
export realm_publicKey="xxx"
export auth_url=https://keycloak.cloudzcp.io/auth
export smtp_pwd=xxx
export s3_accesskey=xxx
export s3_secretkey=xxx

//catalog
export catalog_client_secret=xxx
export catalog_sub_domain=registry-example

//registry
export registry_admin_pwd=xxx
export registry_sub_domain=registry-example
export registry_s3_bucket=zcp-registry-xxx
```

Confirm the env.

```
//common
echo $namespace
echo $domain
echo $tls_secret
echo $realm_publicKey
echo $auth_url
echo $smtp_pwd
echo $s3_accesskey
echo $s3_secretkey

//catalog
echo $catalog_client_secret
echo $catalog_sub_domain

//registry
echo $registry_admin_pwd
echo $registry_sub_domain
echo $registry_s3_bucket
```

## Run installation script

Run installation script and insert a number you want to install.

```
./zcp-installation-scripts.sh
1. All
2. Registry
3. Catalog
Insert a number:
```
