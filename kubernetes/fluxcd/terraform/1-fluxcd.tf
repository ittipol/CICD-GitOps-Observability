# Install manually
# helm repo add fluxcd-community https://fluxcd-community.github.io/helm-charts
# helm repo update
# helm install my-flux2 --namespace fluxcd --create-namespace fluxcd-community/flux2 --version 2.14.0
resource "helm_release" "fluxcd" {
  name = "fluxcd"

  repository       = "https://fluxcd-community.github.io/helm-charts"
  chart            = "flux2"
  namespace        = "fluxcd"
  version          = "2.14.0"
  create_namespace = true

  # values = [file("values/fluxcd_value.yaml")]
}