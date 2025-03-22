# helm repo add istio https://istio-release.storage.googleapis.com/charts
# helm repo update
# helm install istio-gateway -n istio-ingress --create-namespace istio/gateway
resource "helm_release" "gateway" {
  name = "istio-gateway"

  repository       = "https://istio-release.storage.googleapis.com/charts"
  chart            = "gateway"
  namespace        = "istio-ingress"
  create_namespace = true
  version          = "1.25.0"

  # set {
  #   name  = "service.type"
  #   value = "ClusterIP"
  # }

  depends_on = [
    helm_release.istio_base,
    helm_release.istiod
  ]

  # timeout = 600
}