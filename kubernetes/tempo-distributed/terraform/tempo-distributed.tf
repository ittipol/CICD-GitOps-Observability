# Install manually
# helm repo add grafana https://grafana.github.io/helm-charts
# helm repo update
# helm install tempo --namespace tempo --create-namespace --version 1.32.0 --values kubernetes/terraform/values/tempo-helm.yaml grafana/tempo-distributed
resource "helm_release" "tempo" {
  name = "tempo"

  repository       = "https://grafana.github.io/helm-charts"
  chart            = "tempo-distributed"
  namespace        = "tempo"
  version          = "1.32.0"
  create_namespace = true

  values = [file("values/tempo-distributed-helm.yaml")]
}