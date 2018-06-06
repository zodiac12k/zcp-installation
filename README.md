# zcp-installation

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

//registry
export registry_admin_pwd=

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

//registry
export registry_admin_pwd=xxx
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

//registry
echo $registry_admin_pwd
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
