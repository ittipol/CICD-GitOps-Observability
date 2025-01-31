# Install manually
# helm repo add grafana https://grafana.github.io/helm-charts
# helm repo update
# helm install promtail --namespace promtail --create-namespace --version 6.16.6 --values kubernetes/terraform/values/promtail-helm.yaml grafana/promtail
resource "helm_release" "promtail" {
  name = "promtail"

  repository       = "https://grafana.github.io/helm-charts"
  chart            = "promtail"
  namespace        = "promtail"
  version          = "6.16.6"
  create_namespace = true

  # values = [file("values/promtail-helm.yaml")]
}