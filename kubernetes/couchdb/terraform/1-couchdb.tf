# helm repo add couchdb https://apache.github.io/couchdb-helm/
# helm repo update
# helm install couchdb -n couchdb --create-namespace couchdb/couchdb --version 4.6.0
resource "helm_release" "couchdb" {
  name = "couchdb"

  repository       = "https://apache.github.io/couchdb-helm"
  chart            = "couchdb"
  namespace        = "couchdb"
  create_namespace = true
  version          = "4.6.0"

  values = [file("values/couchdb-helm.yaml")]
}