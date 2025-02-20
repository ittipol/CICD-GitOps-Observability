# Install manually
# helm repo add grafana https://grafana.github.io/helm-charts
# helm repo update
# helm install tempo --namespace tempo --create-namespace --version 1.18.2 --values kubernetes/terraform/values/tempo-helm.yaml grafana/tempo
resource "helm_release" "tempo" {
  name = "tempo"

  repository       = "https://grafana.github.io/helm-charts"
  chart            = "tempo"
  namespace        = "tempo"
  version          = "1.18.2"
  create_namespace = true

  values = [file("values/tempo-helm.yaml")]
}