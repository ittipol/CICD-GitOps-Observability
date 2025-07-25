# Kubernetes

## Lightweight Linux images (Lean)
- Alpine image
- Distroless image
- Chainguard image
- Scratch image

## Container security
- Running a container as a non-root user and unprivileged container
- Use lightweight image for base image
- Do not install unnecessary packages in container

## Terraform
- Resource: helm_release https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release

## Init containers
Init containers run and complete their tasks before the main application container starts. init containers are not continuously running alongside the main containers

## Headless Service
A headless service in Kubernetes can be a useful tool for creating distributed applications. It allows you to directly access the individual pods in a service

## Watch for status changes
``` bash
kubectl get [resource] [resources_name] -n [namespace] --watch
# kubectl get pod ingress-nginx-controller-bc57996ff-6r4pj -n ingress-nginx --watch
# kubectl get deployment ingress-nginx-controller -n ingress-nginx --watch
```

## Shell into pod
``` bash
kubectl exec -it {pod_name} -n {namespace} -- sh
kubectl exec -it {pod_name} -n {namespace} -c {container_name}  -- sh
```

## Log streaming
``` bash
kubectl logs -f {pod_name}

# Check the logs for container inside pod in there are multiple containers
kubectl logs -f {pod_name} -c {container_name}
kubectl logs -f {pod_name} -c {container_name} -n {namespace}

# kubectl logs -f go-app-66cf55f986-gqf99 -c go-app -n go-app
```

## Delete all resources
``` bash
kubectl delete all --all -n {namespace}
```

## Ingress
``` bash
curl --resolve "app.api.service:80:$(minikube ip)" -i http://app.api.service
```

## Communication between containers within same pod
**Use localhost to communicate with other containers within the same pod**
- 127.0.0.1:3000
- 127.0.0.1:9000
- 127.0.0.1:3306
``` yaml
spec:
  containers:
    - name: go-app
      image: go-app:2.0
      imagePullPolicy: Never
      ports:
      - containerPort: 3000
        name: http
      - containerPort: 9000
        name: metrics
      resources:
        limits:
          cpu: 500m
          memory: 256Mi
        requests:
          cpu: 500m
          memory: 128Mi
    - name: mysql
      image: mysql:8.0
      ports:
      - containerPort: 3306
        name: http
```

## Connect a service in a different namespace
```
<service_name> (Use if in same namespace)
<service_name>.<namespace_name> (Use if across namespace)
<service_name>.<namespace_name>.svc.cluster.local (FQDN)
```
**DNS pattern** \
{protocol}://{service_name}.{service_namespace}.{Kubernetes_suffix}:{service_port}
```
ex. redis://redis-service.redis-database.svc.cluster.local:6379
```

**Headless service DNS pattern** \
{protocol}://{pod_name}.{service_name}.{service_namespace}.{Kubernetes_suffix}:{service_port}
```
ex. redis://redis-0.redis-service.redis-database.svc.cluster.local:6379
```

**Headless service config**
``` yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: redis
  namespace: redis
spec:
  selector:
    matchLabels:
      app.kubernetes.io/name: redis
  replicas: 6
  serviceName: redis-headless-svc-stateful # Point the serviceName to the headless service that’s responsible for exposing the StatefulSet to the network
  template:
    ...
```

**Test headless service**
``` bash
nslookup redis-0.redis-headless-svc-stateful.redis.svc.cluster.local
```

## Pull Policy
**Always** \
Alway attempts to pull the reference

**Never** \
Never pull the reference and only uses a local image or artifact

**IfNotPresent** \
Pull if the reference isn't already present on disk

## Health Checks (Probes)

- **Liveness probes:** Check if a container is running properly or not, and can be restarted if it is unhealthy
``` yaml
livenessProbe:
  httpGet:
    path: /health
    port: 3000
  initialDelaySeconds: 10
  periodSeconds: 15
```
- **Readiness probes:** Checks if a container is ready to handle traffic, preventing traffic from being sent to unhealthy containers
``` yaml
readinessProbe:
  httpGet:
    path: /health
    port: 3000
  initialDelaySeconds: 10
  periodSeconds: 15
```