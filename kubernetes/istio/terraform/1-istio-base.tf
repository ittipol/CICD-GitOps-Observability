# helm repo add istio https://istio-release.storage.googleapis.com/charts
# helm repo update
# helm install istio-base -n istio-system --create-namespace istio/base --set global.istioNamespace=istio-system
resource "helm_release" "istio_base" {
  name = "istio-base"

  repository       = "https://istio-release.storage.googleapis.com/charts"
  chart            = "base"
  namespace        = "istio-system"
  create_namespace = true
  version          = "1.25.0"

  set {
    name  = "global.istioNamespace"
    value = "istio-system"
  }

  timeout = 600
}