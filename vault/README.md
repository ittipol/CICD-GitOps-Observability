# Vault

``` bash
vault operator init
vault operator init -key-shares=1 -key-threshold=1

export VAULT_TOKEN=<Initial Root Token>

vault operator unseal

vault secrets enable -path=kv kv
vault secrets list -detailed

vault kv put -mount=kv my-secret PASSWORD=password
vault kv get -mount=kv my-secret
```