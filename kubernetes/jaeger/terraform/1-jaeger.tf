# helm repo add jaegertracing https://jaegertracing.github.io/helm-charts
# helm repo update
# helm install jaeger -n jaeger --create-namespace jaegertracing/jaeger --version 3.4.1
resource "helm_release" "jaegertracing" {
  name = "jaeger"

  repository       = "https://kiali.org/helm-charts"
  chart            = "jaeger"
  namespace        = "jaeger"
  create_namespace = true
  version          = "3.4.1"

  # values = [file("values/jaeger-helm.yaml")]
}