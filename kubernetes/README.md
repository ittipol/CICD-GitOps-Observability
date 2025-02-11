# Kubernetes

## Terraform
- Resource: helm_release https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release

## Log streaming
``` bash
kubectl logs -f {pod_name}
```

## Ingress
``` bash
curl --resolve "goapp.example:80:$(minikube ip)" -i http://goapp.example
```