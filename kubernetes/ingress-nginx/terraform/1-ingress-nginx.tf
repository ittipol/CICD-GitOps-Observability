helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update 
helm install ingress-nginx ingress-nginx/ingress-nginx \
--namespace ingress-nginx --create-namespace \
--set controller.metrics.enabled=true \
--set controller.metrics.serviceMonitor.enabled=true \
--set controller.metrics.serviceMonitor.additionalLabels.release="kube-prometheus-stack-release-name" \
--version=4.12.0