# Kubernetes

## Terraform
- Resource: helm_release https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release

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
curl --resolve "goapp.example:80:$(minikube ip)" -i http://goapp.example
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
{protocol}://{service_name}.{service_namespace}.{Kubernetes_suffix}:{service_port} \
redis://redis-service.redis-database.svc.cluster.local:6379