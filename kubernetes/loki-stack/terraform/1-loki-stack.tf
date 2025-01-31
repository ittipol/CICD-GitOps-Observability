# Install manually
# helm repo add grafana https://grafana.github.io/helm-charts
# helm repo update
# helm install loki --namespace loki --create-namespace --version 2.10.2 --values kubernetes/terraform/values/loki-stack.yaml grafana/loki-stack
resource "helm_release" "loki" {
  name = "loki"

  repository       = "https://grafana.github.io/helm-charts"
  chart            = "loki-stack"
  namespace        = "loki"
  version          = "2.10.2"
  create_namespace = true

  values = [file("values/loki-stack.yaml")]
}