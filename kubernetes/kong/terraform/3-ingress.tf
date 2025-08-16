# helm repo add kong https://charts.konghq.com
# helm repo update
# helm install kong-ingress -n kong-ingress --create-namespace kong/ingress --version 0.21.0
resource "helm_release" "kong_ingress" {
  name = "kong-ingress"

  repository       = "https://charts.konghq.com"
  chart            = "ingress"
  namespace        = "kong-ingress"
  create_namespace = true
  version          = "0.21.0"

  depends_on = [
    helm_release.kong_base,
    helm_release.gateway_operator
  ]

  # timeout = 600

  # values = [file("values/ingress-value.yaml")]
}