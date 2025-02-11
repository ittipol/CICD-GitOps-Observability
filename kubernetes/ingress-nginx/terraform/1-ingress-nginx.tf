# Install manually
# helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
# helm repo update 
# helm install ingress-nginx ingress-nginx/ingress-nginx \
# --namespace ingress-nginx --create-namespace \
# --set controller.metrics.enabled=true \
# --set controller.metrics.serviceMonitor.enabled=true \
# --set controller.metrics.serviceMonitor.additionalLabels.release="input-kube-prometheus-stack-release-name" \
# --version=4.12.0

locals {
  helm_extra_args = {
    "controller.metrics.enabled" = "true"
    "controller.metrics.serviceMonitor.enabled" = "true"
    "controller.metrics.serviceMonitor.additionalLabels.release" = "prometheus"
    "controller.service.type" = "NodePort"
  }
}

resource "helm_release" "ingress-nginx" {
  name = "ingress-nginx"

  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  version          = "4.12.0"
  create_namespace = true

  dynamic "set" {
    for_each = local.helm_extra_args
    content {
      name  = set.key
      value = set.value
    }
  }

  # values = [file("values/ingress-nginx.yaml")]

  timeout = 600
}