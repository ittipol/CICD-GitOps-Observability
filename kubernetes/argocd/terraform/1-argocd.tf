# Install manually
# helm repo add argo https://argoproj.github.io/argo-helm
# helm repo update
# helm install argocd --namespace argocd --create-namespace argo/argo-cd --version 7.8.3
resource "helm_release" "argocd" {
  name = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  version          = "7.8.3"
  create_namespace = true

  values = [file("values/argocd_value.yaml")]
}