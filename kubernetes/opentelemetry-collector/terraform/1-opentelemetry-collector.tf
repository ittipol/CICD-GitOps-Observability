# Install manually
# helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts
# helm repo update
# helm install opentelemetry-collector --namespace otelcol --create-namespace --version 0.119.1 --values kubernetes/terraform/values/opentelemetry-collector-helm.yaml open-telemetry/opentelemetry-collector --set mode=<value> --set image.repository="otel/opentelemetry-collector-k8s" --set command.name="otelcol-k8s"

locals {
  helm_extra_args = {
    "mode" = "deployment" # daemonset, deployment or statefulset
    "image.repository" = "otel/opentelemetry-collector-k8s"
    "command.name" = "otelcol-k8s"
  }
}

resource "helm_release" "open-telemetry" {
  name = "opentelemetry-collector"

  repository       = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  chart            = "opentelemetry-collector"
  namespace        = "otelcol"
  version          = "0.119.1"
  create_namespace = true

  # set {
  #   name  = "mode"
  #   value = "deployment"
  # }

  # set {
  #   name  = "image.repository"
  #   value = "otel/opentelemetry-collector-k8s"
  # }

  # set {
  #   name  = "command.name"
  #   value = "otelcol-k8s"
  # }

  dynamic "set" {
    for_each = local.helm_extra_args
    content {
      name  = set.key
      value = set.value
    }
  }

  values = [file("values/opentelemetry-collector-helm.yaml")]
}