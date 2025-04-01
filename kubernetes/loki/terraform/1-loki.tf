# Install manually
# helm repo add grafana https://grafana.github.io/helm-charts
# helm repo update
# helm install loki --namespace loki --create-namespace --version 6.29.0 --values kubernetes/terraform/values/loki-helm.yaml grafana/loki
resource "helm_release" "loki" {
  name = "loki"

  repository       = "https://grafana.github.io/helm-charts"
  chart            = "loki"
  namespace        = "loki"
  version          = "6.29.0"
  create_namespace = true

  values = [file("values/loki-filesystem.yaml")]

  # timeout = 360
}