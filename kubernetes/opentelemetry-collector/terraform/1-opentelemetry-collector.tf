# Install manually
# helm repo add opentelemetry-helm https://open-telemetry.github.io/opentelemetry-helm-charts
# helm repo update
# helm install opentelemetry-collector --namespace opentelemetry-collector --create-namespace --version 0.115.0 --values kubernetes/terraform/values/opentelemetry-collector-helm.yaml opentelemetry-helm/opentelemetry-collector
resource "helm_release" "opentelemetry-collector" {
  name = "opentelemetry-collector"

  repository       = "https://grafana.github.io/helm-charts"
  chart            = "opentelemetry-collector"
  namespace        = "opentelemetry-collector"
  version          = "0.115.0"
  create_namespace = true

  values = [file("values/opentelemetry-collector-helm.yaml")]
}