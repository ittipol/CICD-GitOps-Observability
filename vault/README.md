# Vault

``` bash
vault operator init
vault operator init -key-shares=1 -key-threshold=1
vault operator init -key-shares=1 -key-threshold=1 -format=json > cluster-keys.json

export VAULT_TOKEN=<Initial Root Token>
# or
vault login

# Prints the current state of Vault
vault status

# https://developer.hashicorp.com/vault/docs/commands/token/create
vault token create -period=30m -use-limit=100 -renewable=true -explicit-max-ttl=1h -policy=only-read

vault operator unseal
vault operator unseal $VAULT_UNSEAL_KEY

vault secrets list -detailed

vault auth enable kubernetes
vault write auth/kubernetes/config \
    token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
    kubernetes_host=https://${KUBERNETES_PORT_443_TCP_ADDR}:443 \
    kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
vault policy write webapp-only-read - <<EOF
path "secret/data/webapp/config" {
  capabilities = ["read"]
}
EOF
vault write auth/kubernetes/role/webapp \
    bound_service_account_names=go-app-sa \
    bound_service_account_namespaces=go-app \
    policies=webapp-only-read \
    ttl=24h

vault secrets enable database

vault secrets enable -path=kv kv
vault kv put -mount=kv my-secret PASSWORD=password
vault kv get -mount=kv my-secret

vault secrets enable -path=go-app -version=2 kv
vault kv put -mount=go-app secret/auth ttl=30m username=test password=password
vault kv get -mount=go-app secret/auth

cat <<EOF > /path/to/policy.hcl
path "database/creds/sql-create-user-role" {
  capabilities = ["read"]
}
EOF
vault policy write only-read /path/to/policy.hcl
```

**initializes a Vault server**
``` bash
vault operator init
```

**Unseal a Vault**
``` bash
vault operator unseal
```

**Login**
``` bash
vault login
```

**Create a policy**
1. Go to http://localhost:8200/ui
2. Navigate to policies > ACL Policies
3. Select Create ACL Policy
4. Input Name and Policy
```
# Example policy
path "go-app/*" {
  capabilities = [ "create", "read", "update", "list" ]
}
```
5. Click Create policy

**Create a token**
``` bash
vault token create -period=30m -use-limit=100 -renewable=true -explicit-max-ttl=1h -policy=only-read
vault token create -period=5m -policy=db-user-creation
```