# Install manually
# helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
# helm repo update
# helm install prometheus --namespace prometheus --create-namespace --version 27.5.1 --values kubernetes/terraform/values/prometheus-helm.yaml prometheus-community/prometheus
resource "helm_release" "prometheus" {
  name = "prometheus"

  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "prometheus"
  namespace        = "prometheus"
  version          = "27.5.1"
  create_namespace = true

  values = [file("values/prometheus-value.yaml")]
}