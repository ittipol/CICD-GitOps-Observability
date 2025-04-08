# Install manually
# helm repo add bitnami https://charts.bitnami.com/bitnami
# helm repo update
# helm install kafka --namespace kafka --create-namespace bitnami/kafka --version 32.1.3 -f values/kafka_value.yaml
resource "helm_release" "bitnami" {
  name = "kafka"

  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "kafka"
  namespace        = "kafka"
  version          = "32.1.3"
  create_namespace = true

  values = [file("values/kafka_value.yaml")]
}