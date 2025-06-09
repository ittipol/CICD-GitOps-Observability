# Kubernetes service access

### View service list
``` bash
minikube service list
```

### Access an applications
``` bash
// service type: ClusterIP
minikube service <service-name> --url -n <namespace>

ex. minikube service auth-service --url -n auth-api
```