# helm repo add kiali https://kiali.org/helm-charts
# helm repo update
# helm install kiali-operator -n kiali-operator --create-namespace kiali/kiali-operator --version 2.7.1
resource "helm_release" "kiali-operator" {
  name = "kiali-operator"

  repository       = "https://kiali.org/helm-charts"
  chart            = "kiali-operator"
  namespace        = "kiali-operator"
  create_namespace = true
  version          = "2.7.1"

  values = [file("values/kiali-helm.yaml")]

  # depends_on = [
  #   helm_release.istio_base,
  #   helm_release.istiod
  # ]
}