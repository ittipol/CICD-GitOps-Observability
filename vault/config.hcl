# https://developer.hashicorp.com/vault/docs/configuration
# Apply the configuration
# vault server -config /etc/vault/config.hcl

ui = true
cluster_addr  = "http://127.0.0.1:8201"
api_addr      = "http://127.0.0.1:8200"
disable_mlock = true

storage "file" {
  path = "/opt/vault/data"
}
 
listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
  # tls_cert_file = "/certs/server.crt"
  # tls_key_file  = "/certs/server.key"
}