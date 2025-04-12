# Install manually
# helm repo add strimzi https://strimzi.io/charts
# helm repo update
# helm install kafka-operator --namespace kafka-operator --create-namespace strimzi/strimzi-kafka-operator --version 0.45.0 -f values/kafka_value.yaml
resource "helm_release" "strimzi" {
  name = "kafka-operator"

  repository       = "https://strimzi.io/charts"
  chart            = "strimzi-kafka-operator"
  namespace        = "kafka-operator"
  version          = "0.45.0"
  create_namespace = true

  values = [file("values/kafka_operator_value.yaml")]
}