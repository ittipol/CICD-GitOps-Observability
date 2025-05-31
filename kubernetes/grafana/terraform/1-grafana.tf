# Install manually
# helm repo add grafana https://grafana.github.io/helm-charts
# helm repo update
# helm install grafana --namespace grafana --create-namespace --version 9.2.1 --values kubernetes/terraform/values/grafana-helm.yaml grafana/grafana
resource "helm_release" "grafana" {
  name = "grafana"

  repository       = "https://grafana.github.io/helm-charts"
  chart            = "grafana"
  namespace        = "grafana"
  version          = "9.2.1"
  create_namespace = true

  values = [file("values/grafana-helm.yaml")]
}