# helm repo add kong https://charts.konghq.com
# helm repo update
# helm install kong -n kong --create-namespace kong/kong --version 2.51.0
resource "helm_release" "kong_base" {
  name = "kong"

  repository       = "https://charts.konghq.com"
  chart            = "kong"
  namespace        = "kong"
  create_namespace = true
  version          = "2.51.0"

  # set {
  #   name  = "proxy.type"
  #   value = "NodePort"
  # }

  # set {
  #   name  = "env.database"
  #   value = "off"
  # }

  # values = [file("values/kong-base-value.yaml")]
}