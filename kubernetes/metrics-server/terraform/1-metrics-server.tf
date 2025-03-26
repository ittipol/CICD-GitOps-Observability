# Install manually
# helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
# helm repo update
# helm install metrics-server --namespace metrics-server --create-namespace metrics-server/metrics-server --version 3.12.2 --values kubernetes/terraform/values/metrics-server-helm.yaml
resource "helm_release" "metrics-server" {
  name = "metrics-server"

  repository       = "https://kubernetes-sigs.github.io/metrics-server"
  chart            = "metrics-server"
  namespace        = "metrics-server"
  version          = "3.12.2"
  create_namespace = true

  # values = [file("values/metrics-server-helm.yaml")]
}