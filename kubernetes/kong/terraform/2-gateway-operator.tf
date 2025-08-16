# helm repo add kong https://charts.konghq.com
# helm repo update
# helm install gateway-operator -n kong --create-namespace kong/gateway-operator --version 0.6.1
resource "helm_release" "gateway_operator" {
  name = "gateway-operator"

  repository       = "https://charts.konghq.com"
  chart            = "gateway-operator"
  namespace        = "kong"
  create_namespace = true
  version          = "0.6.1"

  depends_on = [helm_release.kong_base]

  # values = [file("values/gateway-operator-value.yaml")]
}