# Install manually
# helm repo add hashicorp https://helm.releases.hashicorp.com
# helm repo update
# helm install vault --namespace vault --create-namespace hashicorp/vault --version 0.4.0 -f values/vault_value.yaml
resource "helm_release" "vault" {
  name = "vault"

  repository       = "https://helm.releases.hashicorp.com"
  chart            = "vault"
  namespace        = "vault"
  version          = "0.4.0"
  create_namespace = true

  values = [file("values/vault_value.yaml")]
}