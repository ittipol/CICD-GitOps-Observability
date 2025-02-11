# Kubernetes

## Terraform
- Resource: helm_release https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release

## Watch for status changes
``` bash
kubectl get [resource] [resources_name] -n [namespace] --watch
# kubectl get pod ingress-nginx-controller-bc57996ff-6r4pj -n ingress-nginx --watch
# kubectl get deployment ingress-nginx-controller -n ingress-nginx --watch
```

## Log streaming
``` bash
kubectl logs -f {pod_name}
```

## Ingress
``` bash
curl --resolve "goapp.example:80:$(minikube ip)" -i http://goapp.example
```