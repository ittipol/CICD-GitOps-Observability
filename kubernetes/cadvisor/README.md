# cAdvisor
- https://github.com/google/cadvisor
- cAdvisor Kubernetes Daemonset https://github.com/google/cadvisor/tree/master/deploy/kubernetes
- cAdvisor release https://github.com/google/cadvisor/tree/master/deploy/kubernetes

## Install Kustomize
- https://kubectl.docs.kubernetes.io/installation/kustomize/ 

## cAdvisor install
``` bash
# Apply resources from a directory containing kustomization.yaml
kubectl apply -k https://github.com/google/cadvisor/deploy/kubernetes/base?ref=v0.49.2
```