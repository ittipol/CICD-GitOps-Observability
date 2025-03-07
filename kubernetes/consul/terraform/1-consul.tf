# Install manually
# helm repo add hashicorp https://helm.releases.hashicorp.com
# helm repo update
# helm install consul --namespace vault --create-namespace hashicorp/consul --version 1.6.2 -f values/vault_value.yaml
resource "helm_release" "vault" {
  name = "consul"

  repository       = "https://helm.releases.hashicorp.com"
  chart            = "consul"
  namespace        = "vault"
  version          = "1.6.2"
  create_namespace = true

  values = [file("values/consul_value.yaml")]
}